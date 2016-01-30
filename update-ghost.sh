## 
# Based on http://support.ghost.org/how-to-upgrade/

# Backup the content.
# TODO: Add date suffix.
cp -R ./content /tmp/content-backup
cp ./config.js /tmp/config.js-backup

# Download latest version of Ghost.
curl -LOk https://ghost.org/zip/ghost-latest.zip

# Unzip downloaded Ghost.
unzip ./ghost-latest.zip -d /tmp/ghost-latest && rm ghost-latest.zip

# Remove the files that you don't want to update.
rm -R /tmp/ghost-latest/content && /tmp/ghost-latest/config.js

# Replace the old files with the new Ghost files.
rm -r core
cp -u -R /tmp/ghost-latest/* .

# Re-install all dependencies.
rm -r ./node_modules
npm install --production
# npm install sqlite3 --build-from-source

# Restart the server.
pm2 stop REC
NODE_ENV=production pm2 start index.js --name REC