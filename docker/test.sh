sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swift:5.0 \
/bin/sh -c \
"swift test"

sudo docker run \
--rm \
-v `pwd`/:/ZEGBot \
-w /ZEGBot \
swift:5.1.5 \
/bin/sh -c \
"swift test"
