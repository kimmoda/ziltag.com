# 開發者文件

## 相依套件

- ruby 2.2.2
- graphicsmagick
- postgresql

## 開發準備

```
$ bundle
$ bin/rake dev:setup
$ rails s
```

## 部署方式

- push 到 master 分支會自動測試、測試通過後會自動部署
- 平時開發使用 dev 分支

# Email 預覽

http://localhost:3000/rails/mailers/