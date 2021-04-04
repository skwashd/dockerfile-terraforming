FROM alpine:3.13

WORKDIR /app
COPY Gemfile* /app/



RUN adduser -D -u1000 terraforming \
    && apk add --no-cache --update \
      ruby-json \
      ruby-bundler \
    && bundle config set --local without 'test development' \
    && bundle config set --local system 'true' \
    && bundle config set --local frozen 1 \
    && apk add --no-cache --update --virtual .build-deps \
      g++ \
      make \
    && chown -R 1000:1000 /app/ \
    && bundle install -j4 \
    && apk del .build-deps

USER terraforming

CMD ["terraforming", "help"]
