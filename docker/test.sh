sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swiftdocker/swift:latest \
/bin/sh -c \
"swift test"
