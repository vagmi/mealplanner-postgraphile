# Mealplanner postgraphile example

This repo contains example code for running sample schema on postgraphile.

## :hammer: Building

Requires the latest version of `docker` and `docker-compose`.


```
$ docker-compose build .
```

To migrate the database. Run the following

```
$ docker-compose run graphql npm run migrate
```

## :rocket: Running

To start the graphiql interface run the following.

```
$ docker-compose run graphql
```

Now visit [http://localhost:5000/graphiql](http://localhost:5000/graphiql) from your browser.
