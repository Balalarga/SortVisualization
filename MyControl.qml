import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5

Item{
    signal countChanged(int n);
    signal speedChanged(int n);
    signal start();
    property alias type: sortType

    Slider {
        id: rowCount
        width: parent.width
        from: 5;
        to: 50;
        anchors.top: parent.top
        onValueChanged: countChanged(value);
    }
    Slider {
        id: speed
        width: parent.width
        from: 1;
        to: 50;
        anchors.top: rowCount.bottom
        onValueChanged: speedChanged(value);
    }

    ComboBox{
        id: sortType
        anchors.top: speed.bottom;
        width: parent.width
        model: ["Bubble", "Insertion", "Merge"];
    }

    Button{
        id: startButton;
        anchors.top: sortType.bottom;
        width: parent.width
        onClicked: start();
        text: "Start sort";
    }
}
