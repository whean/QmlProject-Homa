import QtQuick 2.11

Item {
    id:clockRoot
    width: 400
    height: 400

    Rectangle{
        id:clockRect
        anchors.fill: parent
        color:"#424242"

        Canvas{
            id:clockCanvas
            property double radius: 150

            width:300
            height: 300
            anchors{
                top:parent.top
                topMargin: 20
                horizontalCenter: parent.horizontalCenter
            }

            onPaint: {
                var ctx = getContext("2d")
                drawBack(ctx)
            }

            function drawBack(ctx){
                var r = radius;
                ctx.save();
                ctx.beginPath();
                ctx.translate(width/2,height/2);
                ctx.clearRect(-r,-r,r*2,r*2);
                ctx.lineWidth = 5;
                ctx.arc(0,0,r-5,0,Math.PI*2,false); //外圆
                ctx.stroke();
                ctx.fillStyle = Qt.rgba(1,1,1,1)
                ctx.fill();
                //画文本
                var numbers = [1,2,3,4,5,6,7,8,9,10,11,12];
                ctx.font = "15px Arial";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                for(var i = 0; i < 12; ++i)
                {
                    var rad = 2*Math.PI/12*numbers[i]-3.14/2;
                    var x = Math.cos(rad)*(r-30);
                    var y = Math.sin(rad)*(r-30);
                    ctx.fillStyle = Qt.rgba(0,0,0,1)
                    ctx.fillText(numbers[i],x,y);
                }
                //画刻度
                ctx.lineWidth = 2;
                for (var i = 0; i <60; ++i)
                {
                    ctx.beginPath();
                    var rad = 2*Math.PI/60*i;
                    var x = Math.cos(rad)*(r-15);
                    var y = Math.sin(rad)*(r-15);
                    var x2 = Math.cos(rad)*(r-10);
                    var y2 = Math.sin(rad)*(r-10);
                    //画线
                    if (i%5 === 0)
                    {ctx.strokeStyle="#000000";}
                    else
                    { ctx.strokeStyle = "#989898";}
                    ctx.moveTo(x,y);
                    ctx.lineTo(x2,y2);
                    ctx.stroke();
                }
                ctx.restore();
            }


        }



        Image{
            id:second_hand
            anchors{
                top:clockCanvas.top
                topMargin: clockCanvas.height/2 - height
                horizontalCenter: clockCanvas.horizontalCenter
            }
            transformOrigin: Item.Bottom
            source: "qrc:/Resourse/Image/clock/hand_second.png"
        }
        Image{
            id:minute_hand
            anchors{
                top:clockCanvas.top
                topMargin: clockCanvas.height/2 - height
                horizontalCenter: clockCanvas.horizontalCenter
            }
            transformOrigin: Item.Bottom
            source: "qrc:/Resourse/Image/clock/hand_minute.png"
        }

        Image{
            id:hour_hand
            anchors{
                top:clockCanvas.top
                topMargin: clockCanvas.height/2 - height
                horizontalCenter: clockCanvas.horizontalCenter
            }
            transformOrigin: Item.Bottom
            source: "qrc:/Resourse/Image/clock/hand_hour.png"
        }

        Timer{
            id:clockTimer
            repeat: true
            interval: 1000
            triggeredOnStart: true

            onTriggered: {
                console.log("clockTimer triggered")
                var currentTime = new Date()
                var second = currentTime.getSeconds()
                var minute = currentTime.getMinutes()
                var hour = currentTime.getHours()%12
                console.log(second+" "+ minute + " " + hour)

                var showSecond = second //30
                var showMinute = showSecond/60 + minute //30.5
                var showHour = showMinute/60 + hour //

                second_hand.rotation = (showSecond/60)*360
                minute_hand.rotation = (showMinute/60)*360
                hour_hand.rotation = (showHour/12)*360

                console.log(showSecond+" "+ showMinute + " " + showHour)
                console.log(second_hand.rotation+" "+ minute_hand.rotation + " " + hour_hand.rotation)
            }
        }

        Rectangle{
            id:clockGlass
            anchors.fill: clockCanvas
            color: "#6E6E6E"
            opacity: 0.5
        }

        Image {
            id: clockCover
            source: "qrc:/Resourse/Image/clock/clock_cover.png"
            anchors.centerIn: parent

        }


    }

    onVisibleChanged: {
        if(true == clockRoot.visible)
            clockTimer.restart()
        else
            clockTimer.stop()

    }
}
