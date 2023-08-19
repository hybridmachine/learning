
#include <QCoreApplication>
#include <QDebug>
#include <QTextStream>
#include <iostream>
#include "radio.h"
#include "station.h"

using namespace std;

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    radio boombox;
    station* channels[3];

    channels[0] = new station(&boombox, 98, "KUTX");
    channels[1] = new station(&boombox, 90, "NPR");
    channels[2] = new station(&boombox, 101, "101X");

    boombox.connect(&boombox, &radio::quit, &a, &QCoreApplication::quit,Qt::QueuedConnection);

    // Connect the channel signal to radio slot
    //for (int idx = 0; idx < 3; idx++)
    //{
    //    station * channel = channels[idx];

    //    boombox.connect(channel, &station::send, &boombox, &radio::listen);
    //}

    do {
        qInfo() << "on, off, test, or quit";
        QTextStream qtin(stdin);
        QString line = qtin.readLine().trimmed().toUpper();

        if (line == "OFF")
        {
            qInfo() << "Turning radio off";
            for (int idx = 0; idx < 3; idx++)
            {
                station * channel = channels[idx];

                boombox.disconnect(channel, &station::send, &boombox, &radio::listen);
            }
            qInfo() << "Radio is off";
        }
        else if (line == "ON")
        {
            qInfo() << "Turning radio on";
            for (int idx = 0; idx < 3; idx++)
            {
                station * channel = channels[idx];

                boombox.connect(channel, &station::send, &boombox, &radio::listen);
            }
            qInfo() << "Radio is on";
        }
        else if (line == "TEST")
        {
            qInfo() << "Testing";
            for (int idx = 0; idx < 3; idx++)
            {
                station * channel = channels[idx];

                channel->broadcast("Test for channel " + channel->name);
            }
            qInfo() << "Testing is complete";
        }
        else if (line == "QUIT")
        {
            qInfo() << "Quitting";
            emit boombox.quit();
            break;
        }
    } while(true);
    return a.exec();
}
