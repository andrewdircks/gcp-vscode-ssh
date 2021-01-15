. settings.sh

CONFIG="\nHost ${IP}        
  HostName ${IP}
  IdentityFile ${SSH_DIR}${KEY_FILENAME}
  User ${USERNAME}"

echo -e "$CONFIG" >> ${VS_CONFIG}