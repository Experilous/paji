FROM node:lts

# Install Android SDK and build tools
RUN apt-get update && apt-get install -y unzip openjdk-17-jdk  && mkdir /android-sdk

WORKDIR /android-sdk

ENV ANDROID_SDK_ROOT /android-sdk
ENV ANDROID_HOME /android-sdk

RUN curl -SL https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -o cmdline-tools.zip && unzip cmdline-tools.zip && rm cmdline-tools.zip  
RUN yes | cmdline-tools/bin/sdkmanager --install "platforms;android-33" "build-tools;33.0.0"  "platform-tools" "cmdline-tools;latest" "emulator"
RUN yes | cmdline-tools/bin/sdkmanager --licenses

# Install React Native dependencies
WORKDIR /workspace # assuming your project code will be here
RUN npm install -g react-native-cli
