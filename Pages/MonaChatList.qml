import QtQuick 2.0
import QtQuick.Layouts 1.3
import SW.PageController.enums 1.0

Item {
    id:monaChatListRoot
    width: 400
    height: 400
    property bool isPressed: false

    Rectangle{
        id:bkRect
        anchors.fill: parent
        color: "black"

        Component{
            id:chatListModel

            ListModel{
                ListElement{
                    name:"吼姆拉"
                }
            }
        }

        Component{
            id:chatListDelegate

            Rectangle{
                id:wrapper
                width: 400
                height: 50
                color:(isPressed&&wrapper.ListView.currentIndex === index)?"#01DF3A":"#9FF781"
                Image {
                    id: chatAvatar
                    source: "qrc:/Resourse/Image/HomaMonster/WildHoma_normal.png"
                    width: 30
                    height: 30
                    fillMode: Image.Stretch
                    anchors{
                        left:parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }
                Text{
                    id:chatText
                    text:name
                    font.pixelSize: 20
                    anchors{
                        left:chatAvatar.right
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                }
                MouseArea{
                    id:chatMouseArea
                    anchors.fill: parent

                    onPressed: {
                        isPressed = true
                        wrapper.ListView.view.currentIndex = index
                    }
                    onReleased: {
                        //_pageController.setData(index)
                        //$pageController.moveTo("MusicPlayer")
                        $pageController.currentPage = PageController.MonaChatMessage
                        isPressed = false
                    }
                }
            }
        }

        ListView{
            id:chatListView
            anchors.fill: parent
            delegate: chatListDelegate
            model: chatListModel.createObject(this)
            focus: false
        }
    }

}
