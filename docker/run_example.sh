sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
shaneqi/swift:4.1 \
bash -c \
"swift run"
