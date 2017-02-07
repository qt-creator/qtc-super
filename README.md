
# Prerequisites:

* Git version 1.8.2 or later  
  For the submodule --remote option, which makes git pull the latest HEAD
  of the right branch for the submodules, instead of a fixed commit.

* Further prerequisites as mentioned in `qtcreator/README.md`

# Initializing

Initialize all submodules and checks out current HEAD of remote branch:

    git checkout <qtcreatorbranch>
    git submodule update --init --remote

# Updating:

Pulls and rebases all initialized submodules to current HEAD of remote branch:

    git pull --rebase
    git submodule update --remote --rebase

# Working:

Set up a submodule for working with gerrit by adding the gerrit remote,
and installing the commit message hook, similar to how it is described in
[Setting up Gerrit (If you did not use the init-repository
scripts)](https://wiki.qt.io/Setting_up_Gerrit#Setting_up_git_hooks).
You might also want to work on a branch in the submodule. Then [work in the
submodule as usual](https://wiki.qt.io/Gerrit_Introduction) and push to
gerrit via the `gerrit` remote.

    cd <submodule>
    # add submodule
    git remote add gerrit ssh://codereview.qt-project.org/qt-creator/<submodule_repository>
    # install hook
    gitdir=$(git rev-parse --git-dir); scp -p codereview.qt-project.org:hooks/commit-msg ${gitdir}/hooks/
    # optional: check out branch
    git checkout <branch>
    # do some work, then push to gerrit
    git push gerrit HEAD:refs/for/<branch>
