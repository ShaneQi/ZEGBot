sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swift:4.2 \
/bin/sh -c \
"swift test"
