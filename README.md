# Node with oracledb

Based on:

- [CollinEstes/docker-node-oracle](https://github.com/CollinEstes/docker-node-oracle)
- [node:8-onbuild](https://github.com/nodejs/docker-node/blob/2924f142789842282890f7b1736578b49b3be78f/8.5/onbuild/Dockerfile)

## What ?

> Docker image to be used for building a container ready with Oracle instant client binaries and all necessary environment variables needed to use the primary Node.js Oracle Database driver libraries:

[strong-oracle](https://github.com/strongloop/strong-oracle)  
[node-oracledb](https://github.com/oracle/node-oracledb)

## Build

```bash
docker build -t siegfried/node-oracledb:v1 .
```

## Use

```dockerfile
FROM siegfried/node-oracledb:v1

LABEL version="1.0"

EXPOSE 3000
```

## FAQ

- **Why u no push on docker hub ?**: because proxy...
