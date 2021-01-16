# global
SSH_DIR=~/.ssh/
PROJECT_NAME=borg-container
KEY_FILENAME=${PROJECT_NAME}-test3
USERNAME=andrewdircks
IP=35.203.27.2
VS_CONFIG=${SSH_DIR}config

# keygen
ssh-keygen -t rsa -f ${SSH_DIR}${KEY_FILENAME} -C ${USERNAME}

# gcp
gcloud config set project ${PROJECT_NAME}
KEYS_STORE="store.txt"
TEMP="temp.txt"
touch ${KEYS_STORE}
gcloud compute project-info describe | tee ${TEMP}
python3 parse_metadata.py ${TEMP} ${KEYS_STORE}
rm ${TEMP}
echo ${USERNAME}:`cat ${SSH_DIR}${KEY_FILENAME}.pub` >> ${KEYS_STORE}
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=${KEYS_STORE}
rm ${KEYS_STORE}

# vscode
CONFIG="\nHost ${IP}        
  HostName ${IP}
  IdentityFile ${SSH_DIR}${KEY_FILENAME}
  User ${USERNAME}"
echo -e "$CONFIG" >> ${VS_CONFIG}

# clean up
rm parse_metadata.py
rm script.sh