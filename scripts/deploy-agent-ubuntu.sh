#!/usr/bin/env bash
set -euo pipefail

WAZUH_MANAGER_IP="${WAZUH_MANAGER_IP:-192.168.30.105}"
WAZUH_AGENT_NAME="${WAZUH_AGENT_NAME:-biosanteweb}"
WAZUH_VERSION="${WAZUH_VERSION:-4.7.5-1}"

echo "[*] Import de la clé GPG officielle Wazuh..."
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | \
  gpg --dearmor -o /usr/share/keyrings/wazuh.gpg
chmod 644 /usr/share/keyrings/wazuh.gpg

echo "[*] Ajout du dépôt APT Wazuh 4.x..."
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | \
  tee /etc/apt/sources.list.d/wazuh.list > /dev/null
apt-get update

echo "[*] Installation de wazuh-agent (${WAZUH_VERSION}) vers ${WAZUH_MANAGER_IP}..."
WAZUH_MANAGER="${WAZUH_MANAGER_IP}" \
WAZUH_AGENT_NAME="${WAZUH_AGENT_NAME}" \
  apt-get install -y "wazuh-agent=${WAZUH_VERSION}"

echo "[*] Activation et démarrage du service..."
systemctl daemon-reload
systemctl enable wazuh-agent
systemctl start wazuh-agent

echo "[*] Désactivation du dépôt pour éviter une mise à jour non planifiée..."
sed -i "s/^deb/#deb/" /etc/apt/sources.list.d/wazuh.list
apt-get update

echo "[+] Agent ${WAZUH_AGENT_NAME} déployé et actif."
