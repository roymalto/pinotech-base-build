start on ~Projects/

Run setup-bahmni.sh

cd ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard

docker compose down

cp ~/Projects/ATISHEALTH/custom-branding/docker-compose.yml ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/

cp ~/Projects/ATISHEALTH/custom-branding/.env ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/

docker compose up -d

chmod +x apply-custom.sh

run apply-custom.sh

