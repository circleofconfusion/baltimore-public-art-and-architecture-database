FROM postgres:13.0
EXPOSE 5432/tcp
ENV POSTGRES_USER=testuser
ENV POSTGRES_PASSWORD=testpass
ADD baltimore_street_art.sql /docker-entrypoint-initdb.d