sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
swift:5.7 \
bash -c \
"swift run"
