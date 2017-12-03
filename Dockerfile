FROM ruby:2.4.2-alpine3.6
MAINTAINER "Gavin Lam <me@gavin.hk>"

ENV \
  DIR="/opt/app" \
  OUTDIR="/mnt/output" \
  # Cloudinary credentials
  CLOUD_NAME="CHANGEME" \
  API_KEY="CHANGEME" \
  API_SECRET="CHANGEME"

# Copy sourcecode into container
WORKDIR ${DIR}
COPY . .

# Install gems
RUN bundle install

# Mount output directory
VOLUME ${OUTDIR}

CMD ["sh", "-c", "cd ${OUTDIR}; ${DIR}/cloudinarydump"]
