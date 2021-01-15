. settings.sh

# ensure this project
gcloud config set project ${PROJECT_NAME}

# file to store formatted keys
KEYS_STORE="store.txt"
touch ${KEYS_STORE}

# read in existing ssh keys (can't just append, annoying)
TEMP="temp.txt"
gcloud compute project-info describe | tee ${TEMP}
python3 parse_metadata.py ${TEMP} ${KEYS_STORE}
rm ${TEMP}

# read in generated public key
echo ${USERNAME}:`cat ${SSH_DIR}${KEY_FILENAME}.pub` >> ${KEYS_STORE}

# add the global ssh key to this compute project
gcloud compute project-info add-metadata --metadata-from-file ssh-keys=${KEYS_STORE}

# clean up
rm ${KEYS_STORE}