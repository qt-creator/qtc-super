import qbs
import qbs.File
import qbs.FileInfo
import qbs.TextFile

Project {
    name: "Qt Creator Super Project"

    qbsSearchPaths: ["qtcreator/qbs"]

// TODO: enable when we can require Qbs 1.8
//    Probe {
//        id: submodules
//        property var modules: []

//        configure: {
//            var mods = [];
//            var gitmodules = new TextFile(FileInfo.joinPaths(path, ".gitmodules"));
//            var module = null;
//            while (!gitmodules.atEof()) {
//                var line = gitmodules.readLine();
//                var modLine = line.match(/^\[submodule "([^"]+)"\]$/);
//                if (modLine) {
//                    module = { _name: modLine[1] };
//                    mods.push(module);
//                } else if (module) {
//                    var propLine = line.match(/^\t([^ =]+) *= *(.*)$/);
//                    if (propLine)
//                        module[propLine[1]] = propLine[2];
//                    else
//                        console.warn("Malformed line in .gitmodules: " + line);
//                }
//            }
//            modules = mods;
//        }
//    }

    SubProject {
        filePath: "qtcreator/qtcreator.qbs"
        Properties {
            additionalPlugins: {
                // TODO remove when we can use the Probe
                var submodules = { modules: [
                        { _name: "fossil", path: "plugins/fossil" }
                    ]}
                var plugins = [];
                submodules.modules.forEach(function(module) {
                    var modulePath = module.path;
                    var qbsBase = FileInfo.fileName(modulePath);
                    if (qbsBase !== "qtcreator") { // skip qtcreator submodule
                        var file = FileInfo.joinPaths(path, modulePath, "plugins", qbsBase,
                                                 qbsBase + ".qbs");
                        if (!File.exists(file))
                            file = FileInfo.joinPaths(path, modulePath, qbsBase + ".qbs");
                        if (File.exists(file))
                            plugins.push(file);
                    }
                });
                return plugins;
            }
        }
    }
}
