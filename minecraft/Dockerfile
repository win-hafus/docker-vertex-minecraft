FROM eclipse-temurin:21-jre-alpine

RUN apk add --no-cache curl gettext && \
    mkdir -p /srv/minecraft/vertex && \
    adduser -D -h /srv/minecraft/vertex hfv5 && \
    chown hfv5:hfv5 /srv/minecraft/vertex && \
    chmod 750 /srv/minecraft/vertex

WORKDIR /srv/minecraft/vertex

COPY --chown=hfv5:hfv5 purpur.jar eula.txt server.properties spigot.yml server-start entrypoint.sh ./
# COPY --chown=hfv5:hfv5 paper-global.yml ./config/

RUN chmod +x server-start entrypoint.sh

USER hfv5

EXPOSE 25565 8080 8100

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./server-start"]
