# global
SSH_DIR="$1"/
PROJECT_NAME="$2"
KEY_FILENAME="$3"
USERNAME="$4"
IP="$5"
VS_CONFIG=${SSH_DIR}config

# test command line args
echo ${SSH_DIR}
echo ${PROJECT_NAME}
echo ${KEY_FILENAME}
echo ${USERNAME}
echo ${IP}

# keygen
ssh-keygen -t rsa -f ${SSH_DIR}${KEY_FILENAME} -C ${USERNAME}

# gcp
gcloud config set project ${PROJECT_NAME}
KEYS_STORE="store.txt"
TEMP="temp.txt"
touch ${KEYS_STORE}
gcloud compute project-info describe | tee ${TEMP}
python3 gcp-vscode-ssh/parse_metadata.py ${TEMP} ${KEYS_STORE}
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