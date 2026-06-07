# Use official Flutter image
FROM google/cloud-builders/docker AS builder

# Install Flutter dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter && \
    cd /flutter && \
    git checkout stable && \
    /flutter/bin/flutter config --no-analytics && \
    /flutter/bin/flutter precache

ENV PATH="/flutter/bin:${PATH}"

# Set working directory
WORKDIR /app

# Copy Flutter project
COPY mentrix_student_app/ .

# Get dependencies
RUN flutter pub get

# Build APK
RUN flutter build apk --release

# Final stage - extract APK
FROM google/cloud-builders/docker
COPY --from=builder /app/build/app/outputs/apk/release/app-release.apk /workspace/app-release.apk

ENTRYPOINT ["cp", "/workspace/app-release.apk", "/workspace/output/"]
