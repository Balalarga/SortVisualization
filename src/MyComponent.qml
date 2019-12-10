import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Item{
    id: root
    property int speed: 1;
    property color fColor: "red";
    property color sColor: "green";
    property color mainColor: "orange";

    Timer {
        id: timer
        repeat: true;
        interval: speed*100;
        property int i: 0
        onTriggered: {
            console.log(i);
            bubbleSort();
            if(i == dataModel.count-2){
                stop();
                triggered.disconnect(bubbleSort);
                i = 0;
            }else{
                i++;
            }
        }
        /*

          Не проверяет первый элемент

          */

        function bubbleSort(){
            dataModel.get(i).color = fColor;
            dataModel.get(i+1).color = sColor;
            timer.start();
            if(dataModel.get(i).value < dataModel.get(i+1).value){
                swap(i, i+1);
                if(i > 1){
                    i-=2;
                }else if(i>0){
                    i--;
                }
            }
            dataModel.get(i).color = mainColor;
            dataModel.get(i+1).color = mainColor;
        }
        function swap(i, j){
            var t = dataModel.get(i).value;
            dataModel.get(i).value = dataModel.get(j).value;
            dataModel.get(j).value = t;
        }
    }

    onSpeedChanged: {
        console.log(speed);
    }
    function setBubbleSort(){
        timer.triggered.connect(timer.bubbleSort());
        timer.start();
    }

    function updateFrame(newCount){
        if(dataModel.count < newCount){
            for(let i = dataModel.count; i < newCount; i++)
                dataModel.addItem();
        }else{
            for(let j = newCount; j < dataModel.count; j++)
                dataModel.remove(dataModel.count-1);
        }
        view.widthUpdate();
    }
    ListModel {
        id: dataModel
        dynamicRoles: true
        onDataChanged: view.widthUpdate();
        function addItem(){
            dataModel.append({color: "orange",
                                 value: Math.random(),
                                 width: getItemWidth()});
            view.widthUpdate();
        }
        function getItemWidth(){
            if(dataModel.count<0)
                return view.width;
            return view.width/dataModel.count-view.spacing;
        }
    }
    ListView {
        id: view
        height: parent.height
        width: parent.width
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 2
        rotation: 180;
        model: dataModel
        orientation: ListView.Horizontal
        delegate: Rectangle {
            property int value: model.value
            width: model.width;
            height: (parent.height)*model.value;
            color: model.color;

        }
        onWidthChanged: widthUpdate();

        function widthUpdate(){
            for(var i = 0; i < dataModel.count; i++){
                dataModel.get(i).width = dataModel.getItemWidth();
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if(mouse.button === Qt.LeftButton)
                dataModel.addItem();
            else if(mouse.button === Qt.RightButton)
                removeRow();
        }
    }
}
