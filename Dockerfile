# Use Ubuntu with Flutter pre-installed
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter config --no-analytics
RUN flutter precache

WORKDIR /app

# Copy project
COPY mentrix_student_app/ .

# Build APK
RUN flutter pub get
RUN flutter build apk --release

# Copy to output
RUN mkdir -p /output
RUN cp build/app/outputs/apk/release/app-release.apk /output/app-release.apk

ENTRYPOINT ["/bin/bash"]
