TEMPLATE = subdirs

mkpath($$OUT_PWD/qtcreator) # so the qtcreator.pro is able to create a .qmake.cache there

SUBDIRS = \
    qtcreator

DISTFILES += .qmake.conf
