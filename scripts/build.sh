sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
shaneqi/swift:4.0 \
/bin/sh -c \
"swift test && swift build"
