# nginx-behavior-test-example

Nginx behavior test example with [docker](https://docker.io) and [infrataster](http://infrataster.net/).

## Requirements

- [docker](https://docker.io)
- [docker-compose](https://docs.docker.com/compose/)

## Setup

- Get docker and docker-compose
    - require docker-compose > 1.6
- Set `DOCKER_HOST` environment variable
    - currently, require start with `tcp://...`
- Install infrataster

```
bundle install
```

## Usage

- Start containers

```
docker-compose up --build
```

- Run spec

```
bundle exec rspec
```

## Components

- HAProxy
    - Imitation load balancer like Amazon ELB
- Nginx
    - Test target
- Mock application
    - Imitation ruby application 

## Auhtor

Yoshikawa Ryota ([@rrreeeyyy](https://github.com/rrreeeyyy))
