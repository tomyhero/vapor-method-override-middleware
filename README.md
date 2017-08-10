# Method Override Middleware

![Vapor](http://img.shields.io/badge/vapor-2.0-brightgreen.svg)


This is Vapor's middleware which override HTTP method like Rack::MethodOverride class in Ruby.
Because of some of browser only support `GET` and `POST' method, we need manually add `PUT`,`PATCH`,`DELETE`,etc...
This middleware help the work.


# Prepare

Add the dependency to Package.swift

```swift
.Package(url: "https://github.com/tomyhero/vapor-method-override-middleware.git", majorVersion: 1)
```

Add this middelware to configuration to `Config+Setup.swift` 

```swift
try addConfigurable(middleware: MethodOverrideMiddleware(), name: "method-override")
```

Activate this middleware to `method-override` to  `droplet.json`

```js
"middleware": [
  "method-override"
]
```

# Usage

You need to set form method as `post` then set override method with `_method` field.

```html
<form method="post">
<input type="hidden" name="_method" value="patch">
```
