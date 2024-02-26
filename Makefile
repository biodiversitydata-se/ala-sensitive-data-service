#! make
package:
	mvn clean package -DskipTests

run: package
	java -jar ala-sensitive-data-server/target/ala-sensitive-data-server-1.2.jar server /data/ala-sensitive-data-service/config/config.yml

clean:
	docker volume rm ala-sensitive-data-service_data_nameindex

run-docker: package
	docker compose -f docker-compose.yml up --detach

release:
	@./sbdi/make-release.sh
