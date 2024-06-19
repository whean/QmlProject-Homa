import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.0
import '../Components'

Item {
    id:monaChatMessageRoot
    width: 400
    height: 400

    property string userName: "myself"

    ListModel{
        id:testListModel
        ListElement{
            sender:"test"
            message:"这是一条测试信息"
        }
        ListElement{
            sender:"myself"
            message:"这是一条测试信息"
        }
    }


    Rectangle{
        id:bk
        color: "white"

        anchors.fill: parent

        Component{
            id:messageDelegate

            Item{
                id:wrap
                width: 400
                height: messagePanel.height+10

                property bool isMyself:sender===monaChatMessageRoot.userName
                //                    Rectangle{
                //                        anchors.fill: parent
                //                        color: "red"
                //                    }

                Item{
                    id:messagePanel
                    width: 250
                    height: messageBK.height
                    anchors{
                        verticalCenter: parent.verticalCenter
                        left: isMyself?undefined:parent.left
                        leftMargin: isMyself?undefined:5
                        right: isMyself?parent.right:undefined
                        rightMargin: isMyself?5:undefined
                    }

                    Rectangle{
                        id:messageBK
                        color: isMyself?"#BCF5A9":"#E6E6E6"
                        anchors{
                            top:parent.top
                            left: isMyself?undefined:parent.left
                            right: isMyself?parent.right:undefined
                        }

                        height: messageText.height+20
                        width: messageText.contentWidth+20
                        radius: 20
                        Text{
//                            anchors{
//                                left: isMyself?undefined:parent.left
//                                leftMargin: isMyself?undefined:10
//                                right: isMyself?parent.right:undefined
//                                rightMargin: isMyself?10:undefined
//                            }
                            anchors{
                                left:parent.left
                                leftMargin: 10
                            }

                            anchors.verticalCenter: parent.verticalCenter
                            id:messageText
                            text:message
                            width: 220
                            horizontalAlignment: Text.AlignLeft
                            font{
                                pixelSize: 15
                            }
                            wrapMode: Text.Wrap
                        }
                    }
                }
            }
        }

        ListView{
            id:messageView
            anchors{
                top:parent.top
                left: parent.left
            }
            width: parent.width
            height: parent.height-editView.height
            spacing: 5
            delegate: messageDelegate
            model: testListModel
            add:Transition {
                NumberAnimation{
                    properties: "x"
                    from:400
                    duration: 1000
                }

            }

            function addMessage(msg){
                testListModel.append({
                                         "sender":"myself",
                                         "message":msg
                                     })
            }
        }

        Rectangle{
            id:editView
            color: "#9FF781"
            y:parent.height-height
            width: 400
            height: messageEdit.height+90

            ScrollTextEdit{
                id:messageEdit
                width: 350
                bkColor: "white"
                maxLineCount: 3

                anchors{
                    top:parent.top
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }

                function getMessage(){
//                    console.log(text+ " "+text.length)
//                    var lines = text.split('\n')
//                    for(var line in lines)
//                    {
//                        line = line.trim()
//                        console.log(line+" "+line.length)
//                    }
//                    text = ""
                    return text

                }

            }

            Button{
                id:sendBtn
                text:qsTr("发送")
                width: 60
                height: 30
                font.pixelSize: 20
                font.bold: true
                anchors{
                    top:messageEdit.bottom
                    topMargin: 20
                    right:parent.right
                    rightMargin: 30
                }

                onClicked: {
                    messageView.positionViewAtEnd()
                    messageView.addMessage(messageEdit.getMessage())
                    messageEdit.text = ""
                }
            }

        }


    }
}
