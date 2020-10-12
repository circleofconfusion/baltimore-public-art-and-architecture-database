FROM postgres:13.0
EXPOSE 5432/tcp
ENV POSTGRES_USER=testuser
ENV POSTGRES_PASSWORD=testpass
ENV PG_MAJOR=13
ENV POSTGIS_MAJOR=3
RUN apt-get update \
      && apt-cache showpkg postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts \
      && rm -rf /var/lib/apt/lists/*
ADD baltimore_street_art.sql /docker-entrypoint-initdb.d/
ADD test_data.sql /docker-entrypoint-initdb.d/