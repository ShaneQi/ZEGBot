sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swift:5.7 \
/bin/sh -c \
"swift test"
