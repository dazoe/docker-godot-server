FROM alpine as builder

ENV GIT_BRANCH "3.2"

RUN apk add alpine-sdk scons libexecinfo-dev \
    && git clone -b ${GIT_BRANCH} https://github.com/godotengine/godot.git

RUN cd /godot; scons -j$(nproc --all) p=server debug_symbols=no use_static_cpp=yes use_lto=yes tools=no target=release

FROM alpine
COPY --from=builder /godot/bin/godot_server.x11.opt.64 /bin/godot-server
