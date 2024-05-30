#include "qwindow.h"
#include "checkeredwindow.h"

#include <QtGui>

void *getQWindowTest() {
    auto contetWindow = new CheckeredWindow();
    contetWindow->setColor(QColor(10, 60, 130));
    contetWindow -> show();
}