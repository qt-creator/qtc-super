TEMPLATE = subdirs

mkpath($$OUT_PWD/qtcreator) # so the qtcreator.pro is able to create a .qmake.cache there

DISTFILES += .qmake.conf

QTC_SKIP_MODULES =
include(submodules.pri)
