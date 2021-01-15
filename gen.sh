source settings.sh

# generate ssh key pair -- how to handle "enter passphrase?"
cd ${SSH_DIR}
ssh-keygen -t rsa -f ${KEY_FILENAME} -C ${USERNAME}