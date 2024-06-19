import QtQuick 2.0

Item {
    id:musicPopup
    width:40
    height:40

    Rectangle{
        anchors.fill: parent
        color: "black"

        Image{
            source: ""
        }
    }

    MouseArea
    {
        anchors.fill: parent

        onPressed: {
            musicPopup.x = mouseX
            musicPopup.y = mouseY
        }

        onReleased: {
            musicPopup.x = musicPopup.x>200?400-musicPopup.width:0;
        }
    }
}
