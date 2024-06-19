import QtQuick 2.0
import QtQuick.Layouts 1.3
import "../Components"

Item {
    id:root
    width: 400
    height: 400


    Image {
        id: bk
        anchors.centerIn: parent
        source: "qrc:/Resourse/Image/Calculator/calculator_bk.png"
    }

    Item{
        id:viewer

        width: 340
        height: 110

        anchors{
            top:parent.top
            topMargin: 20
            left:parent.left
            leftMargin: 30
        }

        Text{
            property string defaultText: "0"
            property int defaultPixelSize: 50
            property int pixelSizeChangeStep: 10
            property int minPixelSize: 30

            property int changeTimes: 0
            property var changeLengths: []
            property int perTextLength:0

            function init()
            {
                expressionText.text = defaultText
            }

            function initSize()
            {
                expressionText.font.pixelSize = defaultPixelSize
                changeLengths = []
            }

            id:expressionText
            width: parent.width-60
            horizontalAlignment: Text.AlignRight
            text:defaultText
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 20
            }
            font{
                pixelSize: defaultPixelSize
                family: "ScreenMatrix"
            }
            wrapMode: Text.WrapAnywhere

            onTextChanged: {
                var curTextLength = expressionText.text.length
                if(perTextLength <= curTextLength)
                {
                    console.log("text++ "+curTextLength)
                    if(expressionText.contentWidth>=expressionText.width-expressionText.font.pixelSize&&expressionText.font.pixelSize>minPixelSize)
                    {
                        font.pixelSize-=pixelSizeChangeStep
                        //changeTimes++
                        console.log("push "+curTextLength)
                        changeLengths.push(expressionText.text.length)
                    }
                }
                else
                {
                    console.log("text-- "+curTextLength)
                    if(curTextLength === changeLengths[changeLengths.length-1])
                    {
                        font.pixelSize+=pixelSizeChangeStep
                        changeLengths.pop()
                    }
                }
                perTextLength = curTextLength
            }


        }
        LPMouseArea{
            anchors.fill: parent
            onReleased: {
                if(expressionText.text.length<2)
                {
                    expressionText.init()
                    return;
                }
                expressionText.text = expressionText.text.slice(0,expressionText.text.length-1)
            }
            onLpTriggered: {
                expressionText.init()
                expressionText.initSize()
            }
        }
    }


    GridLayout{

        anchors{
            top:viewer.bottom
            topMargin: 1
            left: viewer.left
            leftMargin: 1
        }

        rows:3
        columns:4
        rowSpacing: 12
        columnSpacing: 22

        CustomButton{
            id:num_1
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_1_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"1"
            }

            onSigClicked: {
                addToExpression(num_1_text.text)
            }
        }

        CustomButton{
            id:num_2
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_2_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"2"
            }

            onSigClicked: {
                addToExpression(num_2_text.text)
            }
        }

        CustomButton{
            id:num_3
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_3_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"3"
            }

            onSigClicked: {
                addToExpression(num_3_text.text)
            }
        }

        ColumnLayout{
            spacing: 10

            CustomButton{
                id:sym_plus
                width:68
                height: 29

                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"

                Text{
                    id:sym_plus_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"+"
                }

                onSigClicked: {
                    addToExpression(sym_plus_text.text)
                }
            }

            CustomButton{
                id:sym_minus
                width:68
                height: 29
                mirror: CustomButton.Mirror.Vertical
                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"


                Text{
                    id:sym_minus_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"-"
                }

                onSigClicked: {
                    addToExpression(sym_minus_text.text)
                }
            }
        }

        CustomButton{
            id:num_4
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_4_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"4"
            }

            onSigClicked: {
                addToExpression(num_4_text.text)
            }
        }

        CustomButton{
            id:num_5
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_5_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"5"
            }

            onSigClicked: {
                addToExpression(num_5_text.text)
            }
        }

        CustomButton{
            id:num_6
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_6_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"6"
            }

            onSigClicked: {
                addToExpression(num_6_text.text)
            }
        }

        ColumnLayout{
            spacing: 10

            CustomButton{
                id:sym_multi
                width:68
                height: 29

                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"

                Text{
                    id:sym_multi_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"x"
                }

                onSigClicked: {
                    addToExpression(sym_multi_text.text)
                }
            }

            CustomButton{
                id:sym_divi
                width:68
                height: 29
                mirror: CustomButton.Mirror.Vertical
                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"


                Text{
                    id:sym_divi_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"/"
                }

                onSigClicked: {
                    addToExpression(sym_divi_text.text)
                }
            }
        }

        CustomButton{
            id:num_7
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt1_p.png"
            icon:"qrc:/Resourse/Image/Calculator/caculator_bt1.png"

            Text{
                id:num_7_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"7"
            }

            onSigClicked: {
                addToExpression(num_7_text.text)
            }
        }

        CustomButton{
            id:num_8
            width:68
            height: 68

            pressedIcon: "qrc:/Resourse/Image/Calculator/calculator_bt2_p.png"
            icon:"qrc:/Resourse/Image/Calculator/calculator_bt2.png"

            Text{
                id:num_8_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"8"
            }

            onSigClicked: {
                addToExpression(num_8_text.text)
            }
        }

        CustomButton{
            id:num_9
            width:68
            height: 68
            mirror: CustomButton.Mirror.Horizontal
            pressedIcon: "qrc:/Resourse/Image/Calculator/calculator_bt2_p.png"
            icon:"qrc:/Resourse/Image/Calculator/calculator_bt2.png"
            Text{
                id:num_9_text
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.centerIn: parent
                font{
                    pixelSize: 30
                    family: "ScreenMatrix"
                }
                color: parent.isPressed?"#BDBDBD":"white"
                text:"9"
            }

            onSigClicked: {
                addToExpression(num_9_text.text)
            }
        }

        ColumnLayout{
            spacing: 10

            CustomButton{
                id:sym_dot
                width:68
                height: 29

                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"

                Text{
                    id:sym_dot_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"."
                }

                onSigClicked: {
                    addToExpression(sym_dot_text.text)
                }
            }

            CustomButton{
                id:sym_equal
                width:68
                height: 29
                mirror: CustomButton.Mirror.Vertical
                pressedIcon: "qrc:/Resourse/Image/Calculator/caculator_bt3_p.png"
                icon:"qrc:/Resourse/Image/Calculator/caculator_bt3.png"


                Text{
                    id:sym_equal_text
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    anchors.centerIn: parent
                    font{
                        pixelSize: 15
                        family: "ScreenMatrix"
                    }
                    color: parent.isPressed?"#BDBDBD":"white"
                    text:"="
                }

                onSigClicked: {
                    $calculator.calculate(expressionText.text)
                }
            }
        }

    }

    function addToExpression(str){
//        if(expressionText.text == expressionText.defaultText)
//            expressionText.text = ""
//        if(expressionText.text.length < 30)
//            expressionText.text += str
        if(expressionText.text.length >= 30)
            return
        if(expressionText.text == expressionText.defaultText&&str!==".")
            expressionText.text = ""
        var tempStr = expressionText.text + str
        //console.log("tempStr:"+tempStr)
        var inputRegExp = /^[+-]?([0-9]+[+-\/x%.]?)*[0-9]*$/
        if(!inputRegExp.test(tempStr))
        {
            //console.log("input illegal")
            if(tempStr.length < 2)
                expressionText.text = expressionText.defaultText
            return
        }
        expressionText.text = tempStr
    }

    onVisibleChanged: {
        if(!visible)
        {
            expressionText.init()
            expressionText.initSize()
        }
    }

    Connections{
        target: $calculator
        onExpressionChanged:function(exp){
            expressionText.text = exp
        }
    }

}



