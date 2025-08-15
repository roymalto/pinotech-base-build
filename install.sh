mkdir ~/Projects/ATISHEALTH

git clone https://github.com/roymalto/pinotech-base-build.git

mv pinotech-base-build/* . && mv pinotech-base-build/.* . 2>/dev/null
rmdir pinotech-base-build

git clone https://github.com/Bahmni/bahmni-docker.git
cd bahmni-docker/bahmni-standard
cp ~/Projects/ATISHEALTH/custom-branding/docker-compose.yml ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/

cp ~/Projects/ATISHEALTH/custom-branding/.env ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
docker compose up -d

