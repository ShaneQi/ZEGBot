FROM ubuntu:16.04
RUN apt-get update && apt-get install wget clang libicu-dev libpython2.7 libxml2 libcurl3 -y
RUN wget https://swift.org/builds/swift-4.0-release/ubuntu1604/swift-4.0-RELEASE/swift-4.0-RELEASE-ubuntu16.04.tar.gz && tar -xzf swift-4.0-RELEASE-ubuntu16.04.tar.gz && mv swift-4.0-RELEASE-ubuntu16.04 /swift && rm -rf swift-4.0-RELEASE-ubuntu16.04 && rm /swift-4.0-RELEASE-ubuntu16.04.tar.gz
RUN echo 'export PATH=/swift/usr/bin:"${PATH}"' >> ~/.bash_profile && /bin/bash -c "source ~/.bash_profile"
