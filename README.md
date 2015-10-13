# About dockpad

An experimental Docker wrapper around jhung's https://github.com/jhung/docs-template to support:
- local development of Docpad-based sites in a containerized fashion
- publishing the static site to a container that could be shipped around

## Usage

- `git init dockpad-project`
- `cd dockpad-project`
- `git remote add dockpad https://github.com/waharnum/idrc-dockpad.git`
- `git fetch dockpad`
- `git merge dockpad/master`
- `./dockpadctl project-init`

Refer to https://github.com/jhung/docs-template for information about working with the docpad setup
