# About dockpad

An experimental Docker wrapper around jhung's https://github.com/jhung/docs-template to support:
- local development of Docpad-based sites in a containerized fashion
- publishing the static site to a container that can be shipped around

Not ready for prime time.

## Usage
- prereqs: running docker-machine on OSX/Windows (tested only on OSX so far)
- `git init dockpad-project`
- `cd dockpad-project`
- `git remote add dockpad https://github.com/waharnum/idrc-dockpad.git`
- `git fetch dockpad`
- `git merge dockpad/master`
- `./dockpadctl project-init`

## Local Development

- start the development container: `./dockpadctl dev-start`
- make changes to anything in the `/src` directory and site will rebuild while running
- if you change `site-structure.json`, restart the container to pick up the changes: `./dockpadctl dev-restart`
- can destroy the development container when done: `./dockpadctl dev-destroy` (does not affect directories on host)
- follow the docpad log in the container: `./dockpadctl dev-log`

## Updating from changes to docs-template
- `./dockpadctl project-update`

## Creating a static site container
- prereq: running development container
- `./dockpadctl publish-package`

Refer to https://github.com/jhung/docs-template for information about working with docpad itself
