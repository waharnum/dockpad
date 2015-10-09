#!/bin/bash

# Project variables here

DOCKPAD_IMAGE=aharnum/dockpad
PROJECT_NAME=dockpad-test
EXPORT_IMAGE_PREFACE=aharnum
DOCS_TEMPLATE_REPO=https://github.com/jhung/docs-template

# Terrible gigantic case statement as a control

case "$1" in
    dev-start)
        echo "starting development container"
        docker run --name $PROJECT_NAME -d -p 9778:9778 -v `pwd`/site-structure.json:/usr/src/app/site-structure.json -v `pwd`/src:/usr/src/app/src $DOCKPAD_IMAGE
        echo "Development site visible at `docker-machine ip default`:9778"
        echo "Edit files in /src directory to customize site"
        ;;
    dev-restart)
        echo "restarting development container"
        docker restart $PROJECT_NAME
        echo "Restarted, visible at `docker-machine ip default`:9778"
        ;;
    dev-destroy)
        echo "destroying development container"
        docker stop $PROJECT_NAME && docker rm $PROJECT_NAME
        echo "development container destroyed"
        ;;
    dev-log)
        echo "CTRL+C to stop following log"
        docker logs -f $PROJECT_NAME
        ;;
    project-init)
        echo "performing initial project setup"
        git remote add docs-template $DOCS_TEMPLATE_REPO
        git fetch docs-template
        git merge docs-template/master
        echo "setup complete"
        ;;
    project-update)
        DT_REMOTE=`git remote -v | grep "docs-template (fetch)" | cut -f2`
        echo "updating docs-template from $DT_REMOTE"
        git fetch docs-template
        git merge docs-template/master
        ;;
    publish-package)
        docker exec -d $PROJECT_NAME docpad generate --env static
        docker cp $PROJECT_NAME:/usr/src/app/out out
        docker build -t $EXPORT_IMAGE_PREFACE/$PROJECT_NAME .
        rm -r out
        ;;
    *)
        echo "Unrecognized option"
        ;;
esac
