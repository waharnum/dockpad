#!/bin/bash

# Project variables here

PROJECT_NAME=dockpad-test
DOCKER_HUB_NAME=aharnum
DOCS_TEMPLATE_REPO=https://github.com/jhung/docs-template

case "$1" in
    dev-start)
        echo "starting development container"
        docker run --name $PROJECT_NAME -d -p 9778:9778 -v `pwd`/site-structure.json:/usr/src/app/site-structure.json -v `pwd`/src:/usr/src/app/src aharnum/dockpad
        echo "Running at `docker-machine ip default`:9778"
        ;;
    dev-restart)
        echo "restarting development container"
        docker restart $PROJECT_NAME
        echo "Restarted, running at `docker-machine ip default`:9778"
        ;;
    dev-destroy)
        echo "destroying development container"
        docker stop $PROJECT_NAME && docker rm $PROJECT_NAME
        echo "development container destroyed"
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
        docker build -t $DOCKER_HUB_NAME/$PROJECT_NAME .
        rm -r out
        ;;
    *)
        echo "Unrecognized option"
        ;;
esac
