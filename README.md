
1. Preparation

Works inside your ~/Projects folder.

Defines paths for:

pinotech-base-build repo

Destination: ~/Projects/ATISHEALTH

bahmni-docker repo and its bahmni-standard subfolder

Your custom-branding folder with docker-compose.yml and .env

2. Clone or Update Pinotech Base Build

If the repo exists:

Pull latest changes if it’s a git repo.

If not a git repo, uses its existing contents.

If it doesn’t exist:

Clones from https://github.com/roymalto/pinotech-base-build.git.

3. Move Base Build into ATISHEALTH Folder

Creates ~/Projects/ATISHEALTH if it doesn’t exist.

Moves all files (including hidden ones) from pinotech-base-build into ATISHEALTH.

Deletes the now-empty pinotech-base-build folder.

Uses rsync if available for safer moves.

4. Clone or Update Bahmni Docker

If bahmni-docker exists:

Pulls updates if it’s a git repo.

If not:

Clones from https://github.com/Bahmni/bahmni-docker.git.

5. Copy Custom Branding Configs

Copies docker-compose.yml and .env from:
~/Projects/ATISHEALTH/custom-branding/
→ into:
~/Projects/ATISHEALTH/bahmni-docker/bahmni-standard/

6. Start Bahmni

Changes into the bahmni-standard directory.

Runs docker compose up -d (or docker-compose up -d if using v1).

Starts Bahmni containers in the background.

✅ End Result:

You have a ready-to-run Bahmni Docker environment in ~/Projects/ATISHEALTH

It uses your custom Pinotech branding and configuration files

Containers start automatically after setup
