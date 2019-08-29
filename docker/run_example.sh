sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
shaneqi/swift:5.0 \
bash -c \
"swift run"
