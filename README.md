# Origosykkel

This web application displays all bicycle stands and its available bicycles that can be rented from Oslo Bysykkel.

![App](./app.png)

## How to run

First, you need to install Ruby on your computer. I recommend you to use the tool [`rbenv`](https://github.com/rbenv/rbenv) for that. Follow its installation instruction until you're able to run the command `rbenv`. Then run `rbenv install 3.3.1`, which will install the version of Ruby used by this app.

Then execute

```
./bin/setup
```

to setup the development environment.

Then execute

```
./bin/rails server
```

to run the development server. Then visit

```
http://127.0.0.1:3000
```

to browser to its graphical user interface, and

```
http://127.0.0.1:3000/stands
```

to return a list of bicycle stands and information about them.

## How to test

Execute

```
./bin/rails test
```

to run all test, except the system tests.

## How to build and run a Docker container image

Execute

```
./bin/docker_run
```

which will build and run this app in Docker.

## Author

Bao Chi Tran Nguyen.
