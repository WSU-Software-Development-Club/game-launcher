import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: rectangle
    x: 0
    y: 0

    width: 425
    height: 500
    color: "#5bedbc"
    visible: true

    property var counter: 0

    Label {
        id: label
        text: "Random Text"
        y: 200
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button {
        id: button1
        text: "Click me"
        anchors {
            verticalCenterOffset: 30
            horizontalCenterOffset: 0
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        onClicked: {
            console.info("button was clicked")
            label.text = "clicked -> " + counter + " times "
            counter += 1
        }
    }
}
