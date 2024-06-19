import QtQuick 2.0

Rectangle{
    id:loadingPopup
    width: 400
    height: 400
    color: "#4c000000"

    AnimatedImage{
        id:loadingImage
        anchors.centerIn: parent
        source: "qrc:/Resourse/Image/Popups/loading.gif"
        playing: loadingPopup.visible
    }

}
