# 取得一篇文章

請求

`GET /posts/{ID}.json`

回應

```json
{
  "id": 1,
  "title": "Est eos esse sit rem enim corporis sit.",
  "content": "<p>Ut minima cum quibusdam vel. Inventore eligendi voluptatem consequatur qui. Est ea sit voluptates dolores tenetur assumenda. Ut veniam qui voluptatum.</p><img src=\"http://placehold.it/100x100\"><p>Porro harum provident eveniet omnis sed. Provident dolorem qui quo eos odit. Deserunt voluptates nobis autem et molestiae sit. Vel quos nihil quo est voluptatem distinctio consequatur.</p><img src=\"http://placehold.it/100x100\"><p>Sit ut fuga aut sunt autem voluptatibus ullam. Vitae sunt voluptatem libero suscipit. Cum amet maiores ad qui. Exercitationem eaque error inventore labore voluptas.</p><img src=\"http://placehold.it/100x100\">",
  "summary": "Ut minima cum quibusdam vel. Inventore eligendi voluptatem consequatur qui. Est ea sit voluptates dolores tenetur assumenda. Ut veniam qui voluptatum.Porro harum provident eveniet omnis sed. Provident dolorem qui quo eos odit. Deserunt voluptates nobis autem et molestiae sit. Vel quos nihil quo es..."
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
    "id": 167,
    "title": "test",
    "content": "<p>test</p>",
    "summary": "test",
    "created_on": "2015年6月14日",
    "first_photo": {
      "id": 152,
      "image_url": "http://localhost:3000/uploads/photos/image/152/Screenshot_2015-03-08_03.30.22.png",
      "thumb": "http://localhost:3000/uploads/photos/image/152/thumb_Screenshot_2015-03-08_03.30.22.png"
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

```json
{
  "id": 1123,
  "ziltagging_ids": [
    123,
    456
  ]
}
```