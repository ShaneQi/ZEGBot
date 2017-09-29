sudo docker run \
-v `pwd`/:/ZEGBot \
shaneqi/swift:4.0 \
/bin/sh -c \
"\
apt-get update;\
apt-get install uuid-dev -y;\
cd ZEGBot;\
swift build;\
"
