import QtQuick 2.0

Item {
    id:root

    signal pressed();
    signal released();
    signal clicked();
    signal lpReleased();
    signal lpTriggered();

    property bool isLongPress: false

    MouseArea{
        id:lpArea
        anchors.fill: parent

        //propagateComposedEvents: true

        onPressed: {
            lpTimer.stop()
            isLongPress = false
            console.log("LongPress Timer start")
            lpTimer.start()
            root.pressed()
        }

        onReleased: {
            lpTimer.stop()
            if(!isLongPress)
                root.released()
            else
                root.lpReleased()
        }

        onClicked: {
            root.clicked()
        }

    }

    Timer{
        id:lpTimer
        running: false
        repeat: false
        interval: 2000

        onTriggered: {
            root.lpTriggered()
            console.log("LongPress Timer triggered")
            isLongPress = true

        }
    }
}
