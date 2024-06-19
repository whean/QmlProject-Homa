#ifndef SETTINGCONTROLLER_H
#define SETTINGCONTROLLER_H

#include <QObject>
#include <QColor>
#include <QJsonObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonValue>
#include <QJsonParseError>
#include <QFile>
#include <QTextStream>
#include <QHash>
#include <QMetaProperty>

class SettingController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString musicPath READ musicPath WRITE setMusicPath NOTIFY musicPathChanged)
    Q_PROPERTY(HomaType homaType READ homaType WRITE setHomaType NOTIFY homaTypeChanged)
    Q_PROPERTY(QString homaTypeName READ homaTypeName NOTIFY homaTypeChanged)
private:
    explicit SettingController(QObject *parent = nullptr);
    void getBaseConfig(QJsonObject rootobj);
public:
    ~SettingController();

    enum HomaType{
        Wild = 0,
        //Lady,
        Nerd,
        Cool
    };

    Q_ENUM(HomaType)

    static SettingController* getInstance();

    QString musicPath();
    void setMusicPath(QString);
    void setMusicPath(QVariant);
    HomaType homaType();
    void setHomaType(HomaType);
    void setHomaType(QVariant);
    QString homaTypeName();

    void updateJsonConfig();
    void readJsonConfig();

signals:
    void musicPathChanged(QString newPath);
    void homaTypeChanged(HomaType newType);

public slots:


public:
    HomaType m_config_homaType = Wild;
    QString m_config_musicPath = "musicSource";
    QString jsonConfigPath = "config.json";
    QColor theme;
    QMap<QString,QVariant>* configMap;
};

#endif // SETTINGCONTROLLER_H
