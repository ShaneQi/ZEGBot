sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swift:5.0 \
/bin/sh -c \
"swift test"
