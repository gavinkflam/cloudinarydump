FROM alpine:3.6
MAINTAINER "Gavin Lam <me@gavin.hk>"

RUN \
  apk add --no-cache \
    # Ruby and native extension build dependencies
    build-base \
    ruby \
    ruby-dev \
    # JSON native extension for Ruby
    ruby-json \
    # Install runtime dependencies
    bash \
  	curl \
    parallel

ENV \
  APPDIR="/opt/app" \
  OUTDIR="/mnt/output" \
  # Cloudinary credentials
  CLOUD_NAME="CHANGEME" \
  API_KEY="CHANGEME" \
  API_SECRET="CHANGEME"

# Copy sourcecode into container
WORKDIR ${APPDIR}
COPY . .

RUN \
  # Write gem install options into gemrc
  echo "gem: --no-ri --no-rdoc" > ~/.gemrc && \
  # Install bundler
  gem install bundler && \
  # Install gems
  bundle install \
    --without development test \
    --no-cache

# Mount output directory
VOLUME ${OUTDIR}

CMD ["/bin/bash", "-c", "cd ${OUTDIR}; ${APPDIR}/cloudinarydump"]
