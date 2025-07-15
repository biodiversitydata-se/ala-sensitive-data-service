#! make
package:
	# ala-sensitive-data-tools fails with compilation error ans isn't needed for running the service
	mvn clean package -pl '!ala-sensitive-data-tools' -DskipTests

run: package
	java -jar ala-sensitive-data-server/target/ala-sensitive-data-server-1.2.jar server /data/ala-sensitive-data-service/config/config.yml

clean:
	docker volume rm ala-sensitive-data-service_data_nameindex

run-docker: package
	docker compose -f docker-compose.yml up --detach

release:
	../sbdi-install/utils/make-release.sh
