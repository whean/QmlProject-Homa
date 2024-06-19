#include "settingcontroller.h"
#include <QDebug>

SettingController::SettingController(QObject *parent) : QObject(parent)
{
    configMap = new QMap<QString,QVariant>();
    readJsonConfig();
}

void SettingController::getBaseConfig(QJsonObject rootobj)
{
    auto jsonIterator = rootobj.begin();
    while(jsonIterator != rootobj.end())
    {
        QJsonValue jsonValue = *jsonIterator;
        qDebug() << "SettingController::getBaseConfig: value type is "<<jsonValue.type();
        switch(jsonValue.type())
        {
        case QJsonValue::Object:
            getBaseConfig(jsonValue.toObject());break;
        case QJsonValue::Array:break;
        default:
            qDebug() << "SettingController::getBaseConfig: value type is "<<jsonIterator.key()+" "<<jsonIterator.value().toVariant();
            configMap->insert(jsonIterator.key(),jsonIterator.value().toVariant());
        }
        jsonIterator++;
    }
}

SettingController::~SettingController()
{
    qDebug() << "SettingController::~SettingController";
    updateJsonConfig();
}

SettingController *SettingController::getInstance()
{
    static SettingController instance;
    return &instance;

}

QString SettingController::musicPath()
{
    return m_config_musicPath;
}

void SettingController::setMusicPath(QString newPath)
{
    m_config_musicPath = newPath;
    musicPathChanged(newPath);
}

void SettingController::setMusicPath(QVariant newPath)
{
    QString newPathStr = newPath.toString();
    m_config_musicPath = newPathStr;
    musicPathChanged(newPathStr);
}

SettingController::HomaType SettingController::homaType()
{
    return  m_config_homaType;
}

void SettingController::setHomaType(SettingController::HomaType newType)
{
    qDebug() << "SettingController::setHomaType";
    m_config_homaType = newType;
}

void SettingController::setHomaType(QVariant newType)
{
    m_config_homaType = (HomaType)newType.toInt();
    qDebug() << "SettingController::setHomaType" << m_config_homaType;
}

QString SettingController::homaTypeName()
{
    QMetaEnum enumType = QMetaEnum::fromType<HomaType>();
    QString name = enumType.valueToKey(m_config_homaType);
    return name+"Homa";
}

void SettingController::updateJsonConfig()
{
    if(jsonConfigPath.isEmpty())
    {
        qDebug() << "SettingController::updateJsonConfig: no configPath has been indicated";
        return;
    }
    QJsonObject configRoot;
    QJsonObject homaConfig;
    homaConfig.insert("homaType",m_config_homaType);
    QJsonObject musicConfig;
    QJsonObject paths;
    paths.insert("musicPath",m_config_musicPath);
    musicConfig.insert("paths",paths);
    configRoot.insert("homa",homaConfig);
    configRoot.insert("musicPlayer",musicConfig);
    QJsonDocument doc;
    doc.setObject(configRoot);
    QFile jsonFile(jsonConfigPath);
    if(!jsonFile.exists())
        qDebug() << "SettingController::updateJsonConfig: file is not exist,try to create one";
    if(!jsonFile.open(QIODevice::WriteOnly | QIODevice::Truncate))
    {
        qDebug() << "SettingController::updateJsonConfig " << jsonFile.errorString();
        return;
    }
    QTextStream stream(&jsonFile);
    stream.setCodec("UTF-8");

    stream << doc.toJson();
    jsonFile.close();
}

void SettingController::readJsonConfig()
{
    if(jsonConfigPath.isEmpty())
    {
        qDebug() << "SettingController::updateJsonConfig: no configPath has been indicated";
        return;
    }

    QFile jsonFile(jsonConfigPath);
    if(!jsonFile.exists())
        updateJsonConfig();
    if (!jsonFile.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "SettingController::updateJsonConfig " << jsonFile.errorString();
        return;
    }
    QTextStream stream(&jsonFile);
    stream.setCodec("UTF-8");
    QString str = stream.readAll();
    jsonFile.close();
    QJsonParseError jsonError;
    QJsonDocument doc = QJsonDocument::fromJson(str.toUtf8(),&jsonError);
    if (jsonError.error != QJsonParseError::NoError && !doc.isNull()) {
        qDebug() << "SettingController::updateJsonConfig: json format is wrong," << jsonError.error;
        return;
    }
    QJsonObject rootObject = doc.object();
    getBaseConfig(rootObject);
//    auto metaObj = this->metaObject();
//    for(int i=0;i<metaObj->propertyCount();i++)
//    {
//        auto property = metaObj->property(i);
//        QString proName = property.name();
//        QString configKey = proName.right(proName.length()-9);
//        QVariant configValue = configMap->value(configKey);
//        if(!property.write(this,configValue))
//        {
//            qDebug() << "SettingController::updateJsonConfig: change property failed";
//        }
//        else{
//            qDebug() << "SettingController::updateJsonConfig: " + proName + " = "<<configValue;
//        }
//    }
    setHomaType(configMap->value("homaType"));
    setMusicPath(configMap->value("musicPath"));

}
