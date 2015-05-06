# 開發者文件

## 相依套件

- vips
- postgresql

## 開發準備

```
$ bundle
$ bin/rake dev:setup
$ rails s
```

## 開發規矩

- 一律在 `dev` 分支上開發
- 一律使用 `git pull --rebase`。
- 1 個 issue 1 個 branch，命名方式為 `issues/#ID`。
- branch 開發好後送 pull request，只有 PM 可以 merge

## 部署方式

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
