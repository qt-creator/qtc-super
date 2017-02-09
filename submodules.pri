# Extract submodules from .gitmodules.
lines = $$cat(.gitmodules, lines)
for (line, lines) {
    mod = $$replace(line, "^\\[submodule \"([^\"]+)\"\\]$", \\1)
    !equals(mod, $$line) {
        module = $$mod
        modules += $$mod
    } else {
        prop = $$replace(line, "^$$escape_expand(\\t)([^ =]+) *=.*$", \\1)
        !equals(prop, $$line) {
            val = $$replace(line, "^[^=]+= *", )
            module.$${module}.$$prop = $$split(val)
        } else {
            error("Malformed line in .gitmodules: $$line")
        }
    }
}

modules = $$sort_depends(modules, module., .depends .recommends)
modules = $$reverse(modules)
for (mod, modules) {
    deps = $$eval(module.$${mod}.depends)
    recs = $$eval(module.$${mod}.recommends)
    for (d, $$list($$deps $$recs)): \
        !contains(modules, $$d): \
            error("'$$mod' depends on undeclared '$$d'.")

    contains(QTC_SKIP_MODULES, $$mod): \
        next()
    !isEmpty(QTC_BUILD_MODULES):!contains(QTC_BUILD_MODULES, $$mod): \
        next()

    path = $$eval(module.$${mod}.path)
    project = $$eval(module.$${mod}.project)
    isEmpty(project) {
        !exists($$path/$$section(path, /, -1).pro): \
            next()
        $${mod}.subdir = $$path
    } else {
        !exists($$path/$$project): \
            next()
        $${mod}.file = $$path/$$project
        $${mod}.makefile = Makefile
    }
    $${mod}.target = sub-$$mod

    for (d, deps) {
        !contains(SUBDIRS, $$d) {
            $${mod}.target =
            break()
        }
        $${mod}.depends += $$d
    }
    isEmpty($${mod}.target): \
        next()
    for (d, recs) {
        contains(SUBDIRS, $$d): \
            $${mod}.depends += $$d
    }

    SUBDIRS += $$mod
}
