docker run --name dockpad -d -p 9778:9778 -v `pwd`/site-structure.json:/usr/src/app/site-structure.json -v `pwd`/src:/usr/src/app/src waharnum/docpad
echo "Running at `docker-machine ip default`:9778"
