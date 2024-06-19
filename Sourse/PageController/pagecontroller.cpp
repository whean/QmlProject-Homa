#include "pagecontroller.h"
#include <QDebug>

PageController::PageController(QObject *parent) : QObject(parent)
{
    pageStrHash = new QHash<QString,Page>();
    pageStrHash->insert("Home",Home);
    pageStrHash->insert("Clock",Clock);
    pageStrHash->insert("MusicPlayer",MusicPlayer);
    pageStrHash->insert("MusicSelect",MusicSelect);
    pageStrHash->insert("Setting",Setting);
    pageStrHash->insert("MonaChatLogin",MonaChatLogin);
    pageStrHash->insert("Calculator",Calculator);
    m_currentPage = startPage;

    openPages = new QStack<Page>();
    openPages->push(startPage);
    qDebug() << "openPagesNum is"<<openPages->size();
}

PageController *PageController::getInstance()
{
    static PageController instance;
    return &instance;
}

void PageController::setCurrentPageStr(const QString &str)
{
    if(!pageStrHash->contains(str))
    {
        qDebug() << "PageController::setCurrentPageStr(): Page is not exist";
        return;
    }
    setCurrentPage(pageStrHash->value(str));
}

void PageController::setCurrentPage(PageController::Page page)
{
    if(m_currentPage == page)
        return;
    m_currentPage = page;
    openPages->push(page);
    qDebug() << "PageController::setCurrentPage(): top Page is"<< openPages->top() << " open pages number is" << openPages->size();
    emit currentPageChanged(page);
}

PageController::Page PageController::currentPage()
{
    return m_currentPage;
}

void PageController::setShowPopups(PageController::Popup popup)
{
    qDebug() << "PageController::setShowPopups(): showPopups = " << popup;
    m_showPopups = popup;
}

PageController::Popup PageController::ShowPopups()
{
    return m_showPopups;
}

void PageController::setAutoLogin(bool value)
{
    m_autoLogin = value;
}

bool PageController::autoLogin()
{
    return m_autoLogin;
}

void PageController::setPassword(QString value)
{
    m_password = value;
}

QString PageController::password()
{
    return m_password;
}

void PageController::forward()
{
    if(openPages->size()<=1)
        return;
    openPages->pop();
    qDebug() << "PageController::setCurrentPage(): top Page is"<< openPages->top() << " open pages number is" << openPages->size();
    m_currentPage = openPages->top();
    emit currentPageChanged(openPages->top());
}

void PageController::backHome()
{
    qDebug() << "PageController::backHome(): back home";
    if(openPages->top() == Home)
        return;
    openPages->clear();
    setCurrentPage(Home);
}


