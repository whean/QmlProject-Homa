import QtQuick 2.0
import SW.PageController.enums 1.0
import SW.SettingController.enums 1.0

Item {
    id:monster


    property bool isVinking:false
    property bool isClicked: false
    property bool islongPress: false

    signal sigHomaClicked()
    signal sigHomaPressed()
    signal sigHomaReleased()
    signal sigHomaLPReleased()

    width: monsterRectangle.width
    height: monsterRectangle.height

    Rectangle{

        id:monsterRectangle
        width:60
        height: 60
        anchors.fill:parent
        color:"black"
        radius: 10
        AnimatedImage{
            id:monsterImage
            anchors.centerIn: parent
            source: monster.isClicked?"qrc:/Resourse/Image/HomaMonster/"+$settingController.homaTypeName+"_clicked.png":"qrc:/Resourse/Image/HomaMonster/"+$settingController.homaTypeName+"_normal.png"
//                                       (monster.isVinking?"qrc:/Resourse/Image/HomaMonster/Homa_vink.gif":"qrc:/Resourse/Image/HomaMonster/Homa_normal.png")
//            onCurrentFrameChanged: {
//                //console.log("monsterImage.currentFrame:" + currentFrame)
//                //console.log("monsterImage.currentFrame:" + frameCount)
//                if(currentFrame >= frameCount-1)
//                {
//                    monster.isVinking = false
//                    vinkTimer.restart()
//                }

//            }

        }


        MouseArea{
            id:monsterMouseArea
            anchors.fill: parent

            onPressed: {
                console.log("monsterMouseArea pressed")
                monster.isClicked = true
                //vinkTimer.stop()
                pressingTimer.restart()
                sigHomaPressed()
            }

            onReleased: {
                console.log("monsterMouseArea released")
                isClicked = false
                //monster.isVinking = false
                pressingTimer.stop()
                //vinkTimer.restart()
                if(!homaMonster.islongPress)
                {
                    switch($pageController.currentPage){
                    case PageController.Calculator:break;
                    default:$pageController.forward()
                    }


                    sigHomaReleased()
                }
                else
                {
                    sigHomaLPReleased()
                    homaMonster.islongPress = false
                }
            }

            onClicked: {
                sigHomaClicked()
            }
        }
    }

    Timer{
        id:vinkTimer
        repeat: false
        interval: 5000
        running:true
        onTriggered: {
            console.log("vinkTimer.onTriggered")
            monster.isVinking = true
        }
    }

    Timer{
        id:pressingTimer
        repeat: false
        running: false
        interval:2000

        onTriggered: {
            console.log("pressingTimer triggered")
            homaMonster.islongPress = true
            $pageController.backHome()

        }
    }
}
