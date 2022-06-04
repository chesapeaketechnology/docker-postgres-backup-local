ARG BASETAG=alpine
FROM registry1.dso.mil/ironbank/opensource/postgres/postgresql:13.6

ARG GOCRONVER=v0.0.10
ARG TARGETOS
ARG TARGETARCH

USER root
RUN set -x \
	&& yum update && yum install -y ca-certificates curl \
	&& curl -L https://github.com/prodrigestivill/go-cron/releases/download/v0.0.10/go-cron-linux-amd64.gz | zcat > /usr/local/bin/go-cron \
	&& chmod a+x /usr/local/bin/go-cron

ENV POSTGRES_DB="**None**" \
    POSTGRES_DB_FILE="**None**" \
    POSTGRES_HOST="**None**" \
    POSTGRES_PORT=5432 \
    POSTGRES_USER="**None**" \
    POSTGRES_USER_FILE="**None**" \
    POSTGRES_PASSWORD="**None**" \
    POSTGRES_PASSWORD_FILE="**None**" \
    POSTGRES_PASSFILE_STORE="**None**" \
    POSTGRES_EXTRA_OPTS="-Z6" \
    POSTGRES_CLUSTER="FALSE" \
    SCHEDULE="@daily" \
    BACKUP_DIR="/backups" \
    BACKUP_SUFFIX=".sql.gz" \
    BACKUP_KEEP_DAYS=7 \
    BACKUP_KEEP_WEEKS=4 \
    BACKUP_KEEP_MONTHS=6 \
    BACKUP_KEEP_MINS=1440 \
    HEALTHCHECK_PORT=8080

COPY backup.sh /backup.sh

RUN usermod -a -G root postgres
USER postgres:0

VOLUME /backups

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["exec /usr/local/bin/go-cron -s \"$SCHEDULE\" -p \"$HEALTHCHECK_PORT\" -- /backup.sh"]

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f "http://localhost:$HEALTHCHECK_PORT/" || exit 1
