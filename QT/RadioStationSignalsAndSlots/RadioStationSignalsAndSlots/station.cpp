
#include "station.h"


station::station(QObject *parent, int channel, QString name)
{
    this->channel = channel;
    this->name = name;
}

void station::broadcast(QString message)
{
    emit send(channel, name, message);
}
