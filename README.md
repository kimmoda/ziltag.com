[![Build Status](https://semaphoreci.com/api/v1/projects/a08f57bd-e891-4bb0-8e0f-60b00a5d993d/402412/badge.svg)](https://semaphoreci.com/billtag/ziltag-com)

# dev

```
$ docker-compose run --rm app bin/rake dev:setup # for the first time
$ docker-compose up
```

**You must clone [ziltag/frontend-ziltag.com](https://github.com/ziltag/frontend-ziltag.com) and launch with [hotel](https://github.com/typicode/hotel) first**

# GraphQL IDE

http://ziltag.dev/graphiql

# Sign In/Out

```
http://ziltag.dev?sign_in
http://ziltag.dev?sign_out
```

# Commit Message Hook

Save the follwing script in `.git/hooks/commit-msg`, it will add issue number to commit message automatically.

```sh
#!/bin/sh
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ $CURRENT_BRANCH =~ ^issues[^[:digit:]]*([[:digit:]]+)$ ]]; then
  ISSUE_NUMBER=\#${BASH_REMATCH[1]}
  grep -vE '^\s*#' $1 | grep -q $ISSUE_NUMBER || echo [\#${BASH_REMATCH[1]}] >> $1
fi
```

```sh
chmod +x .git/hooks/commit-msg
```
