import QtQuick 2.0
import SW.PageController.enums 1.0

Item {
    id:app
    width:80
    height: 80

    property string target
    property bool isPressed:false
    property string pressedIcon
    property string icon
    Image {
        anchors{
            centerIn: parent
        }

        id: appIcon
        source: isPressed?pressedIcon:icon
    }

    MouseArea{
        id:appMouseArea
        anchors.fill: parent
        onPressed:  {
            app.isPressed = true;
        }
        onReleased: {
            app.isPressed = false;
            setPage();
        }
    }

    function setPage()
    {
        console.log("setPage")
        $pageController.setCurrentPageStr(target)
        console.log($pageController.currentPage)
    }
}
