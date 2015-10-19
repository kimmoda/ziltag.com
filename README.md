[![Build Status](https://semaphoreci.com/api/v1/projects/a08f57bd-e891-4bb0-8e0f-60b00a5d993d/402412/badge.svg)](https://semaphoreci.com/billtag/ziltag-com)

# 相依套件

- ruby 2.2.3
- graphicsmagick
- postgresql

## Ubuntu

- libreadline-dev
- libssl-dev
- libgdbm-dev
- nodejs
- libpq-dev
- clang
- binutils
- make
- graphicsmagick

# 開發準備

```
$ bundle
$ bin/rake dev:setup
$ rails s # or `bundle exec unicorn -c config/unicorn.rb`
```

# Worker

```
$ env QUEUES="mailers,default" QC_MEASURE=true bundle exec rake qc:work
```

# Elasticsearch 中文斷詞設定

```
curl -X POST 127.0.0.1:9200/_all/_close
curl -XPUT '127.0.0.1:9200/_settings' -d '
{
  "analysis":{
    "analyzer":{
      "default":{"type":"cjk"}
    }
  }
}'
curl -X POST 127.0.0.1:9200/_all/_open
```

# Git 流程

- 一律在 `dev` 分支上開發
- 一律使用 `git pull --rebase`。
- 1 個 issue 1 個 branch，命名方式為 `issues/#ID`。
- branch 開發好後送 pull request，只有 PM 可以 merge

# Email 預覽

http://localhost:3000/rails/mailers/

# 登入登出

可再網址加上 `sign_in` 或 `sign_out` 改變登入狀態，例：

```
http://localhost:3000?sign_in
http://localhost:3000?sign_out
```

# 顯示 flash 訊息

可在網址加上 `flash`，例：

```
http://localhost:3000?flash
```

# Commit Message Hook

此 `.git/hooks/commit-msg` 腳本會根據分支名稱，自動在 commit message 上面加上 issue number，便於在 Github 上索引：

```sh
#!/bin/sh
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [[ $CURRENT_BRANCH =~ ^issues[^[:digit:]]*([[:digit:]]+)$ ]]; then
  ISSUE_NUMBER=\#${BASH_REMATCH[1]}
  grep -vE '^\s*#' $1 | grep -q $ISSUE_NUMBER || echo [\#${BASH_REMATCH[1]}] >> $1
fi
```

設定該檔案可執行：

```sh
chmod +x .git/hooks/commit-msg
```
