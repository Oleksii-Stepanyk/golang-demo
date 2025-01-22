# Golang Demo

## Build binary

```sh
GOOS=linux GOARCH=amd64 go build -o golang-demo
chmod +x golang-demo
```

## Preconditions

1. Install and configure PostreSQL db
2. Create schema from file `db_schema.sql`

## Start program

```sh
DB_ENDPOINT=<db_endpoint> DB_PORT=5432 DB_USER=<user> DB_PASS=<password> DB_NAME=<db_name> ./golang-demo
```

## Use program examples
```sh
curl "http://localhost:8080/ping?url=https://google.com" --header "Content-Type:application/text"
curl -X POST "http://localhost:8080/video?id=1&title=Forest_Gump"
curl "http://localhost:8080/videos"
curl "http://localhost:8080/fibonacci?number=7"
curl "http://localhost:8080/memory-leak"
```

## DevOps Part
### Docker
Created `docker-compose.yml` for nginx proxy server, golang app and postgresql. Isolated .go files for docker image created from own `docker-image/Dockerfile`

### Terraform
Folder `terraform` contains **.tf** files that create VPC with public subnets and access to the Internet, security groups for EC2 and RDS, and parameter group for RDS, RDS and EC2 itself. Also, there is `script.sh` file that setups nginx proxy, golang app with **.service**, and postgresql.

### Kubernetes
Using [Kompose](https://kompose.io) translated `docker-compose.yml` to helm chart and refactored it.

### CI/CD
I tried to create a pipeline, but didn't manage to do that. But there is mine working pipeline at [this repo](https://github.com/Oleksii-Stepanyk/gh-actions-workshop)
