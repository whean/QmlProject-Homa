import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.0
import "../Components"

Item{
    id:musicPlayerRoot
    width:400
    height: 400

    property bool isPaused:true
    property string coverSource
    property string musicSource
    property string musicName

    signal sigMovePrevious()
    signal sigMoveNext()


    Rectangle{
        id:musicRect
        anchors.fill:parent
        color: "#424242"

        Text{
            color: "#ffffff"
            font.family: "Comic Sans MS"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 20
            text:musicName
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:parent.top
                topMargin: 5
            }

        }

        Image{
            id:musicCoverSource
            width: 150
            height: 150
            anchors{
                top:parent.top
                topMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            fillMode: Image.Stretch
            source: coverSource

            visible: false
        }

        Rectangle{
            id:musicCoverMask
            anchors.fill: musicCover
            color:"white"
            radius: width/2
            visible: true
        }

        OpacityMask{
            id:musicCover
            anchors.fill: musicCoverSource
            source: musicCoverSource
            maskSource: musicCoverMask

            PropertyAnimation on rotation{
                id:rotateAnimation
                from:0
                to:360
                duration: 10000
                loops: Animation.Infinite
            }
        }
        
        CustomButton{
            id:previousMusic
            icon:"qrc:/Resourse/Image/musicPlayer/music-previous.png"
            pressedIcon: "qrc:/Resourse/Image/musicPlayer/music-previous-p.png"
            width: 40
            height: 40
            anchors{
                left:musicCover.left
                leftMargin: -10
                top:musicCover.bottom
                topMargin: 20
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("move to previous music")
                    sigMovePrevious()
                }
            }
        }
        
        CustomButton{
            id:nextMusic
            icon:"qrc:/Resourse/Image/musicPlayer/music-next.png"
            pressedIcon: "qrc:/Resourse/Image/musicPlayer/music-next-p.png"
            width: 40
            height: 40
            anchors{
                right:musicCover.right
                rightMargin: -10
                top:musicCover.bottom
                topMargin: 20
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    console.log("move to next music")
                    sigMoveNext()
                }
            }
        }
        
        CustomButton {
            id: pauseMusic
            icon:isPaused?
                     "qrc:/Resourse/Image/musicPlayer/music-play.png":"qrc:/Resourse/Image/musicPlayer/music-pause.png"
            pressedIcon: isPaused?
                             "qrc:/Resourse/Image/musicPlayer/music-play-p.png":"qrc:/Resourse/Image/musicPlayer/music-pause-p.png"
            width: 40
            height: 40
            anchors{
                horizontalCenter: musicCover.horizontalCenter
                verticalCenter:  nextMusic.verticalCenter
            }
            onSigReleased: {
                isPaused = !isPaused
////                if(!rotateAnimation.running)
////                    rotateAnimation.start()
//                else()
                if(isPaused)
                {
                    rotateAnimation.pause()
                    musicAudio.pause();
                }
                else{
                    rotateAnimation.resume()
                    musicAudio.play();
                }
            }
        }

        Slider{
            id:musicSlider
            width: 300
            height: 30

            anchors{
                top:pauseMusic.bottom
                topMargin: 10
                horizontalCenter: pauseMusic.horizontalCenter
            }
            //value:musicAudio.position/musicAudio.duration
            live: false
            wheelEnabled: false
            value:musicAudio.position/musicAudio.duration

            onMoved: {
                musicAudio.seek(position*musicAudio.duration)
            }
        }
        
    }


    Audio{
        id:musicAudio
        audioRole: Audio.MusicRole
        source: musicSource
        autoPlay: musicPlayerRoot.visible&&!isPaused

        onPositionChanged: {
            console.log("current position: "+position)
            console.log("current duration: "+ duration)
        }

        onStopped: {
            rotateAnimation.restart()
            if(position >= duration)
                sigMoveNext()
        }
    }

    onVisibleChanged: {
        if(!musicPlayerRoot.visible)
        {
            isPaused = true
            musicAudio.stop()
            rotateAnimation.stop()
        }
        else
        {
            isPaused = false
            musicAudio.play()
            rotateAnimation.restart()
        }
    }


    Component.onCompleted: {
        //var audioIndex = _pageController.getData()

    }
}
