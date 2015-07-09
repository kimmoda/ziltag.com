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

其中 user 可能是 object 或 null，依照是否能找到使用者而定，因為留言未必需要先註冊。

# 取得所有子留言

請求

`GET /comments/{ID}.json`

回應

格式與 `/comments.json` 陣列中的項目相同。