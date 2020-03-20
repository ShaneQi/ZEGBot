sudo docker run \
-it \
--rm \
-v `pwd`:/ZEGBotExample \
-w /ZEGBotExample \
--name ZEGBotExample \
swift:"$1" \
bash -c \
"swift run"
