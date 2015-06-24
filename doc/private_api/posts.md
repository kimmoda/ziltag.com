# 取得一篇文章

請求

`GET /posts/{ID}.json`

回應

```json
{
  "id": 1,
  "title": "標題",
  "content": "<p>內容</p>",
  "created_on": "2015年6月13日",
  "summary": "內容",
  "first_photo": {
    "id": 1,
    "image_url": "http://localhost:3000/uploads/photos/image/1/6.jpg",
    "thumb": "http://localhost:3000/uploads/photos/image/1/thumb_6.jpg"
  }
}
```

# 取得文章列表

請求

`GET /posts.json`

變數 | 型別 | 說明
---  | ---  | ---
page | 數字 | 顯示第 n 頁，可用於捲動載入

回應

```json

[
  {
    "id": 1,
    "title": "標題",
    "content": "<p>內容</p>",
    "created_on": "2015年6月13日",
    "summary": "內容",
    "first_photo": {
      "id": 1,
      "image_url": "http://localhost:3000/uploads/photos/image/1/6.jpg",
      "thumb": "http://localhost:3000/uploads/photos/image/1/thumb_6.jpg"
    }
  }, ...
]
```

# 同時新增文章與樂貼

請求

`POST /posts.json`

```json
{
  "post": {
    "title": "標題",
    "content": "<p>內容</p>"
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
  "id": 1,
  "title": "標題",
  "content": "<p>內容</p>",
  "created_on": "2015年6月13日",
  "summary": "內容",
  "first_photo": {
    "id": 1,
    "image_url": "http://localhost:3000/uploads/photos/image/1/6.jpg",
    "thumb": "http://localhost:3000/uploads/photos/image/1/thumb_6.jpg"
  },
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
    "title": "標題",
    "content": "<p>內容</p>"
  }
}
```

回應

```json
{
  "id": 1,
  "title": "標題",
  "content": "<p>內容</p>",
  "created_on": "2015年6月13日",
  "summary": "內容",
  "first_photo": {
    "id": 1,
    "image_url": "http://localhost:3000/uploads/photos/image/1/6.jpg",
    "thumb": "http://localhost:3000/uploads/photos/image/1/thumb_6.jpg"
  }
}
```

# 更新文章

請求

`PUT /posts/{POST_ID}.json`

```json
{
  "post": {
    "title": "哈囉",
    "content": "<p>世界</p>",
    "published": true
  }
}
```

回應

與「取得一篇文章」相同

# 刪除文章

請求

`DELETE /posts/{POST_ID}.json`

回應

```json
{
  "id": 1123,
  "ziltagging_ids": [
    123,
    456
  ]
}
```