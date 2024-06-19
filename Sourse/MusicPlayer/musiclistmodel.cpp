#include "musiclistmodel.h"
#include <QDebug>

class MusicListData{
public:
    MusicListData(){
        int role = Qt::UserRole;
        m_roleNames.insert(role++,"name");
        m_roleNames.insert(role++,"src");
        m_roleNames.insert(role++,"cover");
    }

public:
    QVector<MusicDetail*> m_data;
    QHash<int,QByteArray> m_roleNames;
};


MusicListModel::MusicListModel(QObject* parent):QAbstractListModel (parent)
{
    refreshData();
    //connect(SettingController::getInstance(),SIGNAL(musicPathChanged(QString)),this,SLOT(refreshData(QString)));
}

int MusicListModel::rowCount(const QModelIndex &parent) const
{
    return musicData->m_data.size();
}

QVariant MusicListModel::data(const QModelIndex &index, int role) const
{

    return  musicData->m_data.value(index.row())->value(role-Qt::UserRole);
}

QHash<int, QByteArray> MusicListModel::roleNames() const
{
    return musicData->m_roleNames;
}

void MusicListModel::setSource(const QString &source)
{
    xmlSource = source;
}

QString MusicListModel::source() const
{
    return xmlSource;
}

void MusicListModel::setUpXmlSource()
{
    if(sourceDir.isEmpty())
    {
        qDebug() << "MusicListModel::setUpXmlSource: no sourceDir has been indicated";
                    return;
    }
    QDir dir(sourceDir);
    if(!dir.exists())
        dir.mkdir(sourceDir);
    QFileInfo dirInfo(dir.absolutePath());
    if(dirInfo.lastModified() == modifyTime)
    {
        return;
    }
    else{
        modifyTime = dirInfo.lastModified();
    }
    QDir coverDir(sourceDir + "/Covers");
    QDir musicDir(sourceDir+"/Musics");
    if(!coverDir.exists())
        coverDir.mkdir(sourceDir + "/Covers");
    if(!musicDir.exists())
        musicDir.mkdir(sourceDir+"/Musics");
    coverDir.setFilter(QDir::Files|QDir::NoDotAndDotDot|QDir::Hidden);
    musicDir.setFilter(QDir::Files|QDir::NoDotAndDotDot|QDir::Hidden);
    coverDir.setSorting(QDir::Time);
    musicDir.setSorting(QDir::Time);
    QFileInfoList coverInfoList = coverDir.entryInfoList();
    QFileInfoList musicInfoList = musicDir.entryInfoList();
    QHash<QString,QString> musics;
    QHash<QString,QString> covers;
    foreach(QFileInfo coverInfo,coverInfoList)
    {
        covers.insert(coverInfo.baseName(),coverInfo.absoluteFilePath());
        qDebug() << coverInfo.baseName() << endl;
    }
    foreach(QFileInfo musicInfo,musicInfoList)
    {
        musics.insert(musicInfo.baseName(),musicInfo.absoluteFilePath());
        qDebug() << musicInfo.baseName();
    }
    QFile file(xmlSource);
    if(!file.exists())
    {
        qDebug() << "MusicListModel::setUpXmlSource：file is not exist,try to create one";
    }
    if(!file.open(QFile::WriteOnly))
    {
        qDebug() << file.errorString();
        return;
    }
    QXmlStreamWriter xmlWriter(&file);
    xmlWriter.setAutoFormatting(true);

    xmlWriter.writeStartDocument();
    xmlWriter.writeStartElement("MusicList");

    xmlWriter.writeAttribute("Modified_Time",QDateTime().currentDateTime().toString("yyyy.MM.dd hh:mm:ss"));

    for(int i =0;i<musics.size();i++)
    {
        xmlWriter.writeStartElement("Music");
        xmlWriter.writeStartElement("Name");
        xmlWriter.writeAttribute("src",musics.values()[i]);
        xmlWriter.writeCharacters(musics.keys()[i]);
        xmlWriter.writeEndElement();
        int index;
        if((index=covers.keys().indexOf(musics.keys()[i]))>=0)
        {
            xmlWriter.writeStartElement("Cover");
            xmlWriter.writeAttribute("src",covers.values()[index]);
            xmlWriter.writeEndElement();
        }
        else
        {
            xmlWriter.writeStartElement("Cover");
            xmlWriter.writeAttribute("src","no_cover");
            xmlWriter.writeEndElement();
        }
        xmlWriter.writeEndElement();
    }

    xmlWriter.writeEndElement();
    xmlWriter.writeEndDocument();
    file.close();
}

void MusicListModel::readXmlSource()
{
    if(musicData == nullptr)
        return;
    QFile file(xmlSource);
    if(!file.open(QFile::ReadOnly))
    {
        qDebug() << "MusicListModel::readXmlSource: " << file.errorString();
        return;
    }
    QXmlStreamReader xmlReader(&file);
    MusicDetail* md;
    QStringRef elementName;
    while (!xmlReader.atEnd())
    {
        xmlReader.readNext();
        elementName = xmlReader.name();
//        qDebug() << xmlReader.tokenString();
//        qDebug() << elementName;

        if(xmlReader.isStartElement())
        {
            if(elementName == "Music")
            {
                md = new MusicDetail();
            }
            else if(elementName == "Name")
            {
                QString sourcePath = xmlReader.attributes().value("src").toString();
                QString name = xmlReader.readElementText();
                md->append(name);
                md->append(sourcePath);

            }
            else if(elementName == "Cover")
            {
                md->append(xmlReader.attributes().value("src").toString());
            }
        }

        else if(xmlReader.isEndElement())
        {
            if(elementName == "Music")
            {
                musicData->m_data.append(md);
//                for(int i = 0;i<md->size();i++)
//                    qDebug() << md->value(i) << " ";
//                qDebug() << endl;
                md = nullptr;
            }
        }
    }
    file.close();
}

MusicDetail MusicListModel::getAllMusic()
{
    MusicDetail musicList;
//    foreach(MusicDetail* md,musicData)
//    {
//        musicList.
//    }
    return musicList;
}

QVariant MusicListModel::getData(const int index, int role)
{
    return  musicData->m_data.value(index)->value(role-Qt::UserRole);
}

void MusicListModel::refreshData(QString newPath)
{
    qDebug() << "MusicListModel::refreshData: refreshData start";
    sourceDir = newPath.length()>0?newPath:sourceDir;
    musicData = new MusicListData();
    setUpXmlSource();
    readXmlSource();
    //dataChanged(createIndex(0,0),createIndex(musicData->m_data.size()-1,0));
    qDebug() << "MusicListModel::refreshData: refreshData end";
}
