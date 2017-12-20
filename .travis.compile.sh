#!/usr/bin/env bash
set -e

docker run -it -u `stat -c "%u:%g" .` -v ~/.aws:/root/.aws -v ${TRAVIS_BUILD_DIR}:/workspace -w /workspace
rajawali/alpine-glibc-android:beta-feature_ndk-r16 /bin/sh -c \
    "./gradlew build test --stacktrace --continue --console=plain"
