sudo docker run \
-v `pwd`/:/ZEGBot \
swift:latest \
/bin/sh -c \
"\
apt-get update;\
apt-get install uuid-dev -y;\
cd ZEGBot;\
swift build;\
"
