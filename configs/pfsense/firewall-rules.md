# Politique de filtrage pfSense (ACL inter-zones)

Les règles pfSense sont évaluées de haut en bas (premier match appliqué), avec refus implicite en fin de table (*Implicit Deny*).

| Ordre | Interface | Source | Destination | Protocole / Ports | Action | Justification |
| :---: | :--- | :--- | :--- | :--- | :---: | :--- |
| 1 | `LAN` | `192.168.10.0/24` | `192.168.30.105` (Wazuh) | `TCP/UDP 1514`, `TCP 1515` | Allow | Collecte et enrôlement agent Windows |
| 2 | `LAN` | `192.168.10.0/24` | `192.168.30.105` (Wazuh) | `TCP 443` | Allow | Accès Dashboard SOC (à restreindre au poste admin) |
| 3 | `LAN` | `192.168.10.0/24` | `192.168.30.0/24` | `Any` | Block | Isolation de la zone SOC |
| 4 | `LAN` | `192.168.10.0/24` | `WAN` (Internet) | `TCP/UDP 53`, `TCP 80`, `TCP 443` | Allow | Egress Filtering (navigation & mises à jour) |
| 5 | `DMZ` | `192.168.20.0/24` | `192.168.10.0/24` | `Any` | Block | Cloisonnement strict DMZ vers LAN |
| 6 | `DMZ` | `192.168.20.0/24` | `192.168.30.105` (Wazuh) | `TCP/UDP 1514`, `TCP 1515` | Allow | Collecte et enrôlement agent Nginx/Ubuntu |
| 7 | `DMZ` | `192.168.20.0/24` | `WAN` (Internet) | `TCP/UDP 53`, `TCP 80`, `TCP 443` | Allow | Egress Filtering (mises à jour paquets) |
| 8 | `SOC` | `192.168.30.0/24` | `WAN` (Internet) | `TCP/UDP 53`, `TCP 80`, `TCP 443` | Allow | Flux CTI / NVD / mises à jour Wazuh |
| 9 | `WAN` | `192.168.1.50` (Kali) | `192.168.20.22` | `TCP 22` | Temp | **Uniquement pour Scénario 1** — supprimée après test |
| 10 | `All` | `Any` | `Any` | `Any` | Block | Refus par défaut (*Implicit Deny*) |
