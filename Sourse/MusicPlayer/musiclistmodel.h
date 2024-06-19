#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QXmlStreamReader>
#include <QXmlStreamWriter>
#include <QDateTime>
#include "settingcontroller.h"

typedef QVector<QString> MusicDetail;

class MusicListData;

class MusicListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource)

public:
    MusicListModel(QObject* parent = nullptr);

    int rowCount(const QModelIndex& parent) const override;
    QVariant data(const QModelIndex& index,int role) const override;
    QHash<int,QByteArray> roleNames() const override;

    void setSource(const QString& source);
    QString source() const;

public slots:
    void setUpXmlSource();
    void readXmlSource();
    MusicDetail getAllMusic();
    QVariant getData(const int index,int role);
    void refreshData(QString newPath = "");
private:
    MusicListData* musicData;
    QDateTime modifyTime;
    QString xmlSource = "guide.xml";

    QString sourceDir = SettingController::getInstance()->m_config_musicPath;

};

#endif // MUSICLISTMODEL_H
