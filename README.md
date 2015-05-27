[![Build Status](https://semaphoreci.com/api/v1/projects/a08f57bd-e891-4bb0-8e0f-60b00a5d993d/402412/badge.svg)](https://semaphoreci.com/billtag/ziltag-com)

# 相依套件

- ruby 2.2.2
- graphicsmagick
- postgresql

# 開發準備

```
$ bundle
$ bin/rake dev:setup
$ rails s
```

# Git 流程

- 一律在 `dev` 分支上開發
- 一律使用 `git pull --rebase`。
- 1 個 issue 1 個 branch，命名方式為 `issues/#ID`。
- branch 開發好後送 pull request，只有 PM 可以 merge

# 部署方式

push 後會自動測試、測試通過後會自動部署

# Email 預覽

http://localhost:3000/rails/mailers/

# 前端開發

- CSS 檔案放在 `app/assets/stylesheets/application/`。
- JS 檔案放在 `app/assets/javascripts/application/`。
- 最後 CSS 與 JS 會個別壓縮、打包輸出一個檔案，注意 `class` 或 `data-*` 撞名問題。
- 一個功能/樣式定義一個檔案，並註解使用方法。
- JS 應用 `data-*` 找元件，CSS 則用 `class`，誤將行為與樣式共用 `class` 屬性。
- Bower 在 rails 上的使用是在 `Gemfile` 定義 gem，以 `rails-assets-名稱` 的方式安裝。
- Gemfile 新增東西後要 `bundle install`，然後再重開 server，Rails 才抓得到。
- 盡量使用有 bower 控管的 JS/CSS 函式庫，若函式庫非 bower 所管理，則丟到 `vender/assets/{stylesheets,javascripts}` 下，並在 `application.{js,css}` 中透過註解 `require` 引用。
- 為了支援 rails turbolinks 的加速功能，載入頁面除了監聽 `ready` 之外，也請監聽 `page:load` 事件，例如 `$(document).on('ready page:load', myListener);`

# 登入登出

可再網址加上 `sign_in` 或 `sign_out` 改變登入狀態，例：

```
http://localhost:3000?sign_in
http://localhost:3000?sign_out
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

# 樂貼格式

```html
<div class="ziltag_wrapper" data-ziltag-wrapper>
  <img src="">
  <a class="ziltag_sticker" data-ziltag-sticker data-x="10" data-y="10"></a>
  <a class="ziltag_sticker" data-ziltag-sticker data-x="10" data-y="390"></a>
  <a class="ziltag_sticker" data-ziltag-sticker data-x="190" data-y="390"></a>
  <a class="ziltag_sticker" data-ziltag-sticker data-x="190" data-y="10"></a>
  <a class="ziltag_sticker" data-ziltag-sticker data-x="17" data-y="332"></a>
  ...
</div>
```