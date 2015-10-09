docker exec -d dockpad docpad generate --env static
docker cp dockpad:/usr/src/app/out out
