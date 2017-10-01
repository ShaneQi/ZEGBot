sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
shaneqi/swift:4.0-DEVELOPMENT-SNAPSHOT-2017-09-30-a \
bash -c \
"swift run"
