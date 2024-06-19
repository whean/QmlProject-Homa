import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtMultimedia 5.8
import SW.models 1.0
import SW.PageController.enums 1.0

Item {
    id:musicSelectRoot

    width:400
    height:400

    property bool isPressed: false
    property Playlist musicList

    signal sigMusicSelected(string name,string src,string cover)

    Component{
        id:musicSelectModel

        MusicListModel{

        }
    }

    Component{
        id:musicSelectDelegate

        Item{
            id:wrapper
            width:400
            height: 25

            property bool isCurrentItem:wrapper.ListView.view.currentIndex === index


            Rectangle{
                id:background
                color: (isPressed&&isCurrentItem)?"#AC58FA":"#424242"
                anchors.fill: parent

                Text{
                    id:musicName
                    text:name
                    anchors{
                        left: parent.left
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                    font{
                        bold: true
                        pixelSize: 15
                        family: "Comic Sans MS"
                    }
                    color:"white"
                }

                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        isPressed = true
                        wrapper.ListView.view.currentIndex = index
                    }
                    onReleased: {
                        //_pageController.setData(index)
                        //$pageController.moveTo("MusicPlayer")
                        $pageController.currentPage = PageController.MusicPlayer
                        sigMusicSelected(name,src,cover)
                        isPressed = false
                    }


                }
            }

            onIsCurrentItemChanged:{
                if(isPressed === false&&isCurrentItem)
                    sigMusicSelected(name,src,cover)
            }

        }
    }

    Component{
        id:musicSelectHeader

        Item{
            id:header
            width:400
            height: 60



            Rectangle{
                anchors.fill:parent
                gradient: Gradient{
                    GradientStop{
                        position: 0.0
                        color: "#6A0888"
                    }
                    GradientStop{
                        position: 0.5
                        color:"#AC58FA"
                    }
                    GradientStop{
                        position: 1.0
                        color: "#6A0888"
                    }
                }
                Text{
                    text:qsTr("名称")
                    anchors{
                        left: parent.left
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                    font{
                        bold: true
                        pixelSize: 30
                        family: "Comic Sans MS"
                    }
                    color:"white"
                }

//                Text{
//                    text:qsTr("播放次数")
//                    anchors{
//                        right:parent.right
//                        rightMargin: 20
//                        verticalCenter: parent.verticalCenter
//                    }
//                    font.pixelSize: 30
//                    color:"white"
//                }
            }

        }

    }

    Rectangle{
        color: "#424242"
        anchors.fill: parent

        ListView{
            id:musicSelectListView
            focus: false
            anchors.fill:parent
            header: musicSelectHeader
            delegate: musicSelectDelegate
            model: musicSelectModel.createObject(this)


            onCurrentIndexChanged: {
                console.log("musicSelect currentIndex:"+currentIndex)
            }

            Connections{
                target: $settingController
                onMusicPathChanged:function(){
                    musicSelectListView.model = musicSelectModel.createObject(this)
                }
            }
        }
    }

    function movePrevious(){
        musicSelectListView.currentIndex -= 1
        if(musicSelectListView.currentIndex<0)
            musicSelectListView.currentIndex+=musicSelectListView.count
    }

    function moveNext(){
        musicSelectListView.currentIndex = (musicSelectListView.currentIndex+1)%musicSelectListView.count
    }


}
