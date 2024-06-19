import QtQuick 2.0
import QtQuick.Controls 2.4

Item {
    id:root

    height:calSize()



    property alias bkColor: bk.color
    property alias bkRadius :bk.radius
    property int contentMargin: 2
    property int maxLineCount: 4
    property alias text: textArea.text
    property alias font: textArea.font

    ScrollView{
        id:scrollView
        anchors.fill: parent
        contentWidth: width
        background: Rectangle{
            id:bk
            color: "white"
            radius:20
        }

        TextArea{
            id:textArea
            width: root.width-2*contentMargin
            wrapMode: TextEdit.Wrap
            font.pixelSize: 20

            onLineCountChanged: {
                console.log("LineCount:"+lineCount)
            }

            onImplicitHeightChanged: {
                console.log("ImplictHeight"+implicitHeight)
            }

            Component.onCompleted: {
                console.log("ImplictHeight"+implicitHeight)
            }
        }

    }

    function calSize(){
        if(textArea.lineCount <2)
        {
            return textArea.font.pixelSize+20
        }
        else if(textArea.lineCount >=2 && textArea.lineCount<=maxLineCount)
        {
            return textArea.contentHeight+20
        }
        else{
            return root.height
        }

    }
}
