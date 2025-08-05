# pinotech-base-build
Development base build for Pinotech EMR server


Manual Install on Local Server (confirmed working)
# Create on target Server
mkdir ~/Projects
mkdir ~/Projects/ATISHEALTH
mkdir ~/Projects/ATISHEALTH/custom-branding

#Move to Source Server
#To copy branding Run This on 192.168.1.35 (source server):
rsync -avz /home/roym/Projects/ATISHEALTH/custom-branding/ roym@192.168.1.34:/home/roym/Projects/ATISHEALTH/custom-branding/

#to copy script Run This on 192.168.1.35 (source server):
scp /home/roym/Projects/ATISHEALTH/apply-branding.sh roym@192.168.1.34:/home/roym/Projects/ATISHEALTH/

to copy docker.compose.yml Run This on 192.168.1.35 (source server):
scp /home/roym/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/docker-compose.yml roym@192.168.1.34:/home/roym/Projects/ATISHEALTH/custom-branding/

#Move to Target Server
cd ~/Projects/ATISHEALTH
git clone https://github.com/Bahmni/bahmni-docker.git
cd bahmni-docker/bahmni-standard
cp /home/roym/Projects/ATISHEALTH/custom-branding/docker-compose.yml /home/roym/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
docker compose up -d

cd ~/Projects/ATISHEALTH/
chmod +x apply-branding.sh
./apply-branding.sh

#Flush Cloudflare cache or use incognito
To do – update github to match files
-	custom-branding directory and contents
-	apply-branding.sh
-	docker-compose.yml


To be created as script (not confirmed)

#Create directories
mkdir ~/Projects
mkdir ~/Projects/ATISHEALTH

#Download code
cd ~/Projects/ATISHEALTH
git clone https://github.com/Bahmni/bahmni-docker.git
git clone https://github.com/roymalto/pinotech-base-build.git

#Move custom files
mv pinotech-base-build/* . && mv pinotech-base-build/.* . 2>/dev/null
rmdir pinotech-base-build

#copy configs and start
cd ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard
cp ~/Projects/ATISHEALTH/custom-branding/docker-compose.yml ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
cp ~/Projects/ATISHEALTH/custom-branding/.env ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard
docker compose up -d

#Enable script and apply branding
cd ~/Projects/ATISHEALTH
chmod +x apply-branding.sh
./apply-branding.sh




Vanilla Install of Bahmni

# create directories
mkdir ~/Projects
mkdir ~/Projects/ATISHEALTH

#download Bahmni code
cd ~/Projects/ATISHEALTH
git clone https://github.com/Bahmni/bahmni-docker.git
docker compose up -d

# this only installs emr unless .env is changed into bahmni-standard, atomfeed-



# download customization and move custom files
git clone https://github.com/roymalto/pinotech-base-build.git
mv pinotech-base-build/* . && mv pinotech-base-build/.* . 2>/dev/null
rmdir pinotech-base-build

#copy configs and start
cd ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard
cp ~/Projects/ATISHEALTH/custom-branding/docker-compose.yml ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/
cp ~/Projects/ATISHEALTH/custom-branding/.env ~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard




#Enable script and apply branding
cd ~/Projects/ATISHEALTH
chmod +x apply-branding.sh
./apply-branding.sh



# Bahmni Base Build with Custom Branding

This repo automates setting up Bahmni with Pinotech branding.

## 🚀 Quick Setup

```bash
git clone https://github.com/roymalto/pinotech-base-build.git
cd bahmni-base-build
chmod +x install.sh
./install.sh
