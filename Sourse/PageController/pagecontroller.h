#ifndef PAGECONTROLLER_H
#define PAGECONTROLLER_H

#include <QObject>
#include <QString>
#include <QUrl>
#include <QStack>
#include <QHash>
#include<QVariant>

class PageController : public QObject
{
    Q_OBJECT
    
    Q_PROPERTY(PageController::Page currentPage WRITE setCurrentPage READ currentPage NOTIFY currentPageChanged)
    Q_PROPERTY(PageController::Popup showPopups WRITE setShowPopups READ ShowPopups NOTIFY showPopupsChanged)

    Q_PROPERTY(QString password WRITE setPassword READ password)

public:
    enum Page{
        NoPage,
        Home,
        Clock,
        MusicSelect,
        MusicPlayer,
        Setting,
        MonaChatLogin,
        MonaChatMessage,
        MonaChatList,
        Calculator
    };

    enum Popup{
        NoPopup = 0x00,
        VolumePopup = 0x01,
        LoadingPopup = 0x02,
        MusicPopup = 0x04
    };
    
    explicit PageController(QObject *parent = nullptr);
    static PageController* getInstance();
    void setCurrentPage(Page page);
    Page currentPage();
    void setShowPopups(Popup popup);
    Popup ShowPopups();
    void setAutoLogin(bool value);
    bool autoLogin();
    void setPassword(QString value);
    QString password();
    
    
    
    Q_ENUM(Page)
    Q_ENUM(Popup)
    Q_DECLARE_FLAGS(PopupFlags,Popup)
    Q_FLAG(PopupFlags)

signals:
    void currentPageChanged(Page page);
    void showPopupsChanged();
    void autoLoginChanged();

public slots:
    void setCurrentPageStr(const QString& str);
    void forward();
    void backHome();

private:
    //PageSwitch
    QHash<QString,Page>* pageStrHash;
    QStack<Page>* openPages;
    Page startPage = Home;
    Page m_currentPage;
    Popup m_showPopups = NoPopup;
    //LoginStatus
    QString m_password;
    bool m_autoLogin;
};

#endif // PAGECONTROLLER_H
