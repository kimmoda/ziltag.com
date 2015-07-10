# 透過圖片 ID 取得留言

請求

`GET /comments.json?photo_id={ID}`

參數     | 必填 | 說明
---      | ---  | ---
photo_id | 是   | 圖片 ID
page     | 否   | 頁數（每頁 10 筆）

回應

```json
[
  {
    "id": 10,
    "text": "Voluptas aliquid excepturi eos.",
    "email": "orlando@example.org",
    "x": 150,
    "y": 25,
    "comment_id": null,
    "photo_id": 10,
    "created_at": "2015-07-08T20:27:41.678+08:00",
    "updated_at": "2015-07-08T20:27:41.678+08:00",
    "user": {
      "id": 1,
      "email": "orlando@example.org",
      "username": "kayli_willms",
      "avatar_thumb_url": "http://localhost:3000/uploads/users/avatar/1/thumb_5.jpg"
    },
    "children": [
      ...
    ]
  },
  ...
]
```

- `user` 可能是 `object` 或 `null`，依照是否能找到使用者而定，因為留言未必需要先註冊。
- `comment_id` 可能是 `null`，依照是否為父留言而定。

# 取得所有子留言

請求

`GET /comments/{ID}.json`

回應

格式與 `/comments.json` 陣列中的項目相同。

# 新增留言

請求

`POST /comments.json`

```json
{
  "comment": {
    "text": "留言測試",
    "comment_id": 123,
    "x": 123,
    "y": 456,
    "email": "xxx@yyy.zzz",
    "user_id": 123,
    "photo_id": 9527,
  }
}
```

- `email` 與 `user_id` 擇一，依照訪客留言或會員留言而定。
- 座標（`x` 與 `y`）與 `comment_id` 擇一，依照是否為父留言或子留言而定，子留言的座標值並不重要。

回應

格式與 `/comments.json` 陣列中的項目相同。

# 更新留言

請求

`PUT /comments/{ID}.json`

格式與「新增留言」相同

回應

格式與 `/comments.json` 陣列中的項目相同。

# 刪除留言

請求

`DELETE /comments/{ID}.json`

回應

200 OK