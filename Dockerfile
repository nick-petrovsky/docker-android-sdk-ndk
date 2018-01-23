FROM openjdk:8-jdk

MAINTAINER Nick Petrovsky <nick.petrovsky@gmail.com>

ENV ANDROID_COMPILE_SDK "26"
ENV ANDROID_BUILD_TOOLS "27.0.3"
ENV ANDROID_SDK_TOOLS_REV "4333796"  
ENV ANDROID_CMAKE_REV "3.6.4111459"

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools/:${ANDROID_NDK_HOME}

RUN mkdir -p ${ANDROID_HOME}/licenses
RUN echo Cjg5MzNiYWQxNjFhZjQxNzhiMTE4NWQxYTM3ZmJmNDFlYTUyNjljNTU= | base64 -d > ${ANDROID_HOME}/licenses/android-sdk-license
RUN wget --quiet --output-document=${ANDROID_HOME}/android-sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip
RUN unzip -qq ${ANDROID_HOME}/android-sdk.zip -d ${ANDROID_HOME}
RUN rm ${ANDROID_HOME}/android-sdk.zip
RUN echo 'count=0' > $HOME/.android/repositories.cfg

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --update 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'tools' 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'platform-tools' 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'build-tools;'$ANDROID_BUILD_TOOLS 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'platforms;android-'$ANDROID_COMPILE_SDK 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;android;m2repository' 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;google;google_play_services' 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;google;m2repository' 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'cmake;'$ANDROID_CMAKE_REV 
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'ndk-bundle' 

