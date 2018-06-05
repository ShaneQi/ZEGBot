sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swiftdocker/swift:4.1 \
/bin/sh -c \
"swift test"
