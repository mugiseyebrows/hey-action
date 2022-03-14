QT += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

SOURCES += main.cpp

INCLUDEPATH += $$PWD/../Qwt-6.2.0-mingw64/include

LIBS += -L$$PWD/../Qwt-6.2.0-mingw64/lib

CONFIG(debug, debug|release) {
    LIBS += -lqwtd
} else {
    LIBS += -lqwt
}
