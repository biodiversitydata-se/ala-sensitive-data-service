FROM eclipse-temurin:11

# Define the argument
ARG SDS_BASE_URL=https://sds.biodiversitydata.se

# Set the environment variable
ENV SDS_BASE_URL=${SDS_BASE_URL}

RUN mkdir -p \
    /data/lucene/namematching \
    /data/ala-sensitive-data-service/config \
    /data/sds/config \
    /data/biocache/layers

COPY ala-sensitive-data-server/target/ala-sensitive-data-server-1.2.jar /data/ala-sensitive-data-service/ala-sensitive-data-server.jar
COPY sbdi/data/ala-sensitive-data-service/config/config.yml /data/ala-sensitive-data-service/config/ala-sensitive-data-service-config.yml
COPY sbdi/data/sds/config/sds-config.properties /data/sds/config/sds-config.properties
COPY sbdi/data/sds/legacy-sds-config.properties /data/sds/sds-config.properties

RUN curl -sf -o /data/sds/layers.json -L ${SDS_BASE_URL}/ws/layers \
    && curl -sf -o /data/sds/sensitivity-categories.xml -L ${SDS_BASE_URL}/sensitivity-categories.xml \
    && curl -sf -o /data/sds/sensitivity-zones.xml -L ${SDS_BASE_URL}/sensitivity-zones.xml \
    && curl -sf -o /data/sds/sensitive-species-data.xml -L ${SDS_BASE_URL}/sensitive-species-data.xml
RUN curl -sf -o /data/biocache/layers/sds-layers.tgz -L https://archives.ala.org.au/archives/layers/sds-layers.tgz
RUN tar zxf /data/biocache/layers/sds-layers.tgz -C /data/biocache/layers/

EXPOSE 9189
EXPOSE 9190

CMD ["java", "-jar", "/data/ala-sensitive-data-service/ala-sensitive-data-server.jar", "server", "/data/ala-sensitive-data-service/config/ala-sensitive-data-service-config.yml"]
