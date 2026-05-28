FROM eclipse-temurin:21-jre-alpine

RUN apk add --no-cache curl=8.19.0-r0 gettext=0.24.1-r1 && \
    mkdir -p /srv/minecraft/vertex /run/minecraft && \
    adduser -D -h /srv/minecraft/vertex hfv5 && \
    chown hfv5:hfv5 /srv/minecraft/vertex /run/minecraft && \
    chmod 750 /srv/minecraft/vertex

WORKDIR /srv/minecraft/vertex

COPY --chown=hfv5:hfv5 purpur.jar eula.txt server.properties spigot.yml server-start entrypoint.sh ./
COPY --chown=hfv5:hfv5 config/paper-global.yml.template ./config/

RUN chmod +x server-start entrypoint.sh

USER hfv5

EXPOSE 25566 25575 24454/udp 8080

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./server-start"]
