# API

This file can be compiled to HTML by:

```
rdoc API.md
```

## POST /api/v1/sign_in

request:

```json
{
  "user": {
    "login": "username or email",
    "password": "password"
  }
}
```

response:

```json
{
  "avatar": {
    "thumb": "image thumb url",
    "url": "image url"
  },
  "confirmed?": true,
  "email": "email",
  "id": 1,
  "username": "username"
}
```

## POST /api/v1/users

request:

```json
{
  "user": {
    "username": "username",
    "email": "email"
  }
}
```

response:

```json
{
  "avatar": {
    "thumb": "image thumb url",
    "url": "image url"
  },
  "confirmed?": false,
  "email": "email",
  "id": 11,
  "username": "username"
}
```

## GET /api/v1/sign_out

## GET /api/v1/ziltag_maps/MAP_ID

response:

```json
{
  "width": 200,
  "height": 200,
  "host": "host",
  "href": "href",
  "id": "xxxxxx",
  "src": "image url",
  "ziltags": [
    {
      "id": "xxxxxx",
      "preview": "preview",
      "usr": {
        "avatar": "image url",
        "name": "username"
      },
      "x": 0.0548825139469473,
      "y": 0.501225367522604
    }, ...
  ]
}
```

## GET /api/v1/ziltags/ZILTAG_ID

response:

```json
{
  "comments": [
    {
      "content": "raw content",
      "id": 121,
      "usr": {
        "avatar": "image url",
        "name": "username"
      }
    }, ...
  ],
  "content": "raw content",
  "id": "xxxxxx",
  "map_id": "map id",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## POST /api/v1/ziltags

request:

```json
{
  "ziltag": {
    "x": 0.1,
    "y": 0.1,
    "content": "content",
    "map_id": "xxxxxx"
  }
}
```

response:

```json
{
  "comments": [],
  "content": "content",
  "id": "xxxxxx",
  "map_id": "yyyyyy",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## PATCH /api/v1/ziltags/ZILTAG_ID

request:

```json
{
  "ziltag": {
    "x": 0.1,
    "y": 0.1,
    "content": "content"
  }
}
```

response:

```json
{
  "comments": [],
  "content": "content",
  "id": "xxxxxx",
  "map_id": "yyyyyy",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## DELETE /api/v1/ziltags/ZILTAG_ID

## POST /api/v1/comments

request:

```json
{
  "comment": {
    "content": "content",
    "ziltag_id": "xxxxxx"
  }
}
```

response:

```json
{
  "content": "content",
  "id": 190,
  "created_at": "2015-12-09 19:35:23 +0800",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## GET /api/v1/comments/COMMENT_ID

response:

```json
{
  "content": "content",
  "id": 190,
  "created_at": "2015-12-09 19:35:23 +0800",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## PATCH /api/v1/comments/COMMENT_ID

request:

```json
{
  "comment": {
    "content": "content"
  }
}
```

response:

```json
{
  "content": "content",
  "id": 190,
  "created_at": "2015-12-09 19:35:23 +0800",
  "usr": {
    "avatar": "image url",
    "name": "username"
  }
}
```

## DELETE /api/v1/comments/COMMENT_ID

## GET /api/v1/me

response:

```json
{
  "usr": {
    "avatar": "http://localhost:3000/uploads/users/avatar/1/thumb_18.jpg",
    "confirmed": true,
    "name": "jeremy",
    "email": "email@test.com"
  }
}
```

# POST /api/v1/resend_confirmation

request:

```json
{"email": "user@test.com"}
```

success:

```json
{}
```

failure:

```json
{"errors": [...]}
```