FROM elixir:1.6
ENV APP_ROOT /app
WORKDIR $APP_ROOT
COPY . $APP_ROOT
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get
RUN mix deps.compile
CMD mix phx.server
