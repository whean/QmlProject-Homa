import QtQuick 2.9
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3
import "./Components"
import "./Pages"
import SW.PageController.enums 1.0
import QtQuick.Dialogs 1.3
import QtQuick.Controls 2.4
import Qt.labs.platform 1.0

Window{
    visible: true
    width: 400
    height: 400
    maximumHeight: 400
    maximumWidth: 400
    minimumHeight: 400
    minimumWidth: 400
    title: qsTr("HomaWatch")

    PageLoader{
        id:pageLoader
    }

//    MonaChatMessage{

//    }

    PopupLoader{
        z:1
    }

    Homa{
        id:homaMonster
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 20
//        anchors.right: parent.right
//        anchors.rightMargin: 20

   }



//   MessageDialog{
//       id:messageDialog
//       standardButtons: StandardButton.Ok
//       modality: Qt.ApplicationModal

//   }

    Connections{
        target: $monaChatController
        onSigShowDialog:function(text,detail){
            messageDialog.text = text
            messageDialog.detailedText = detail
            messageDialog.open()
        }
    }

    SystemTrayIcon{
            visible: true
            iconSource: "qrc:/Resourse/Image/HomaMonster/WildHoma_normal.png"

            // add menu
            menu: Menu {
                MenuItem {
                    text: qsTr("Quit")
                    onTriggered: Qt.quit()
                }
            }
        }


    Connections{
        target:homaMonster
        onSigHomaPressed:pageLoader.calcAdd_0()
    }

    FontLoader{
        name:"ScreenMatrix"
        source: "qrc:/Resourse/Font/ScreenMatrix-1.ttf"
    }

//    Keys.onDigit0Pressed: {
//        $pageController.showPopups |= PageController.LoadingPopup
//    }
}
