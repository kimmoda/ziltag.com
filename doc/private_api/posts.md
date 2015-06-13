# 同時新增文章與樂貼

請求

`POST /posts.json`

```json
{
  "post": {
    "title": "謝謝你",
    "content": "<p>九五二七</p>"
  },
  "ziltagging": {
    "x": 123,
    "y": 321,
    "photo_id": 339078012
  }
}
```

回應

```json
{
  "id": 123456,
  "title": "謝謝你",
  "content": "<p>九五二七</p>",
  "ziltagging": {
    "id": 654321,
    "x": 123,
    "y": 321,
    "photo_id": 339078012
  }
}
```

# 只新增單篇文章

請求

`POST /posts.json`

```json
{
  "post": {
    "title": "謝謝你",
    "content": "<p>九五二七</p>"
  }
}
```

回應

```json
{
  "id": 123456,
  "title": "謝謝你",
  "content": "<p>九五二七</p>"
}
```

# 更新文章

請求

`PUT /posts/{POST_ID}.json`

```json
{
  "post": {
    "title": "哈囉",
    "content": "<p>世界</p>"
  }
}
```

回應

200 OK

# 刪除文章

請求

`DELETE /posts/{POST_ID}.json`

回應

200 OK