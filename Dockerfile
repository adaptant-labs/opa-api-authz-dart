FROM google/dart:2.6-dev AS dart-runtime

WORKDIR /app

ADD pubspec.* /app/
RUN pub get
ADD bin /app/bin/
ADD lib /app/lib/
RUN pub get --offline
RUN dart2native /app/bin/server.dart -o /app/server

FROM frolvlad/alpine-glibc:alpine-3.9_glibc-2.29

COPY --from=dart-runtime /app/server /server

CMD []
ENTRYPOINT ["/server"]

EXPOSE 8080
