sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
swiftdocker/swift:latest \
bash -c \
"rm -rf .build && swift run"
