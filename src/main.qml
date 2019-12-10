import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Window {
    width: 360
    height: 360
    visible: true

    MyComponent{
        id: view
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 2*parent.width/3;
    }

    MyControl {
        id: control
        anchors.left: view.right
        anchors.right: parent.rigth
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: parent.width-view.width
        onSpeedChanged: {
            view.speed = n;
        }
        onCountChanged: view.updateFrame(n);
        onStart: {
            if(type.currentText == "Bubble"){
                view.setBubbleSort();
            }else if(type.currentText == "Insertion"){

            }
        }
    }
}
