FROM eclipse-temurin:21-jre-alpine

RUN mkdir -p /srv/minecraft/velocity && \
    adduser -D -h /srv/minecraft/velocity hfv5 && \
    chown hfv5:hfv5 /srv/minecraft/velocity && \
    chmod 750 /srv/minecraft/velocity

WORKDIR /srv/minecraft/velocity

COPY --chown=hfv5:hfv5 velocity.jar eula.txt velocity.toml server-start entrypoint.sh ./

RUN chmod +x server-start entrypoint.sh

USER hfv5

EXPOSE 25565

CMD ["./entrypoint.sh"]
