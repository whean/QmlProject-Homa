import QtQuick 2.0
import SW.PageController.enums 1.0
import "./Pages"

Item {
    id:pageLoader
    x:0
    y:0


    Clock{
        id:clock
        visible: $pageController.currentPage === PageController.Clock
    }

    Home{
        id:home
        visible: $pageController.currentPage === PageController.Home
    }

    MusicPlayer{
        id:musicPlayer
        visible: $pageController.currentPage === PageController.MusicPlayer
    }

    MusicSelect{
        id:musicSelect
        visible: $pageController.currentPage === PageController.MusicSelect

    }

    Setting{
        id:setting
        visible: $pageController.currentPage === PageController.Setting

    }

    MonaChatLogin{
        id:monaChatLogin
        visible: $pageController.currentPage === PageController.MonaChatLogin
    }

    MonaChatList{
        id:monaChatList
        visible: $pageController.currentPage === PageController.MonaChatList
    }

    MonaChatMessage{
        id:monaChatMessage
        visible: $pageController.currentPage === PageController.MonaChatMessage
    }

    Calculator{
        id:calculator
        visible: $pageController.currentPage === PageController.Calculator
    }

    Connections{
        target: musicSelect
        onSigMusicSelected:function(name,src,cover){
            if(cover === "no_cover")
                musicPlayer.coverSource = "qrc:/Resourse/Image/musicPlayer/no_cover.png"
            else
                musicPlayer.coverSource = "file:///" + cover
            console.log(name)
            console.log(src)
            console.log(cover)
            musicPlayer.musicName = name
            musicPlayer.musicSource = "file:///"+src

        }
    }

    Connections{
        target: musicPlayer
        onSigMovePrevious:musicSelect.movePrevious()
        onSigMoveNext:musicSelect.moveNext()
    }


    function calcAdd_0()
    {
        calculator.addToExpression("0")
    }




}
