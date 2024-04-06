FROM alpine:3.19 as build

ARG fabric_url
ARG lithium_mod_url

WORKDIR /tmp/server
ADD "$fabric_url" ./server.jar
COPY ./start-server.sh .
COPY ./server.properties .
RUN echo 'eula=true' > eula.txt

WORKDIR /tmp/mods
ADD "$lithium_mod_url" ./lithium-fabric.jar

WORKDIR /tmp/datapack
COPY ./datapack/ ./servinator

FROM amazoncorretto:21-alpine-jdk as release

LABEL org.opencontainers.image.name="Fabric Minecraft Server"
LABEL org.opencontainers.image.authors="sharpscontainer"
LABEL org.opencontainers.image.description="A simple Fabric server for Minecraft that self terminates"
LABEL org.opencontainers.image.source="https://github.com/sharp378/PaperMC"

COPY --from=build --chmod=755 /tmp/server /tmp/server
COPY --from=build --chmod=755 /tmp/mods /tmp/mods
COPY --from=build --chmod=755 /tmp/datapack /tmp/datapack

RUN addgroup --gid 1000 fabric \
  && adduser --disabled-password --uid 1000 --ingroup fabric fabric \
  && chown fabric:fabric /home/fabric

WORKDIR /home/fabric
USER fabric:fabric

VOLUME /home/fabric
EXPOSE 25565

ENV SERVINATOR_INTERVAL=5

ENTRYPOINT ["/tmp/server/start-server.sh"]
