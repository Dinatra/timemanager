##
# Build
##
FROM elixir:1.13-alpine as Build


#   [Setup]
ENV MIX_ENV=prod
WORKDIR /app


#   [Deps]
RUN mix local.hex --force
RUN mix local.rebar --force

COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN apk add build-base
RUN mix deps.compile


#   [Compile]
COPY config ./config
COPY lib ./lib
COPY priv ./priv

RUN mix release

##
# Final
##

FROM alpine:latest AS App

RUN apk update && apk add bash libstdc++ inotify-tools libgcc

ENV MIX_ENV=prod
WORKDIR /app

RUN adduser -h /home/app -D app
WORKDIR /home/app

COPY --from=Build /app/_build .

RUN chown -R app: ./prod
USER app

CMD ["/bin/sh", "-c", "sleep 10 ; ./prod/rel/timemachine/bin/timemachine eval Timemachine.Release.migrate; ./prod/rel/timemachine/bin/timemachine eval Timemachine.Release.seed ; ./prod/rel/timemachine/bin/timemachine start"]