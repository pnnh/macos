import QtQuick

Rectangle {
    width: 300
    height: 200
    color: "#41CD52"
    border.color: "#ffffff"

    Text {
        id: text 
        text: qsTr("Hello World")
        font.pixelSize: 50
        color: "#015FB8"
        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("clicked")
            text.text = "clicked"
        }
    }
}
