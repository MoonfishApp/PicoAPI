# PicoAPI

A description of this package.


## Build

See https://github.com/swift-server/swift-aws-lambda-runtime

To build this package, run the command:
`swift package archive`

`swift package --disable-sandbox archive`

```
curl \
    --header "Content-Type: application/json" \
  --request POST \
  --data '{"prompt": "Tell me a joke"}' \
  http://localhost:7000/invoke
  ```
