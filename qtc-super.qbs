import qbs
import qbs.File
import qbs.FileInfo

Project {
    name: "Qt Creator Super Project"

    qbsSearchPaths: ["qtcreator/qbs"]

    SubProject {
        filePath: "qtcreator/qtcreator.qbs"
    }
}
