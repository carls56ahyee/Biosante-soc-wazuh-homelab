# Checklist de durcissement avant mise en production (SOC Wazuh)

- [ ] **Hyperviseur Proxmox VE** : Activer la 2FA sur l'interface web, restreindre son exposition au seul réseau d'administration et maintenir les paquets à jour.
- [ ] **Accès SSH** : Désactiver l'authentification par mot de passe au profit des clés SSH et interdire `PermitRootLogin`.
- [ ] **Wazuh & Dashboard** : Remplacer tous les mots de passe générés par défaut, créer des comptes nominatifs (RBAC) et limiter l'accès HTTPS (443) au poste d'administration dédié.
- [ ] **Synchronisation NTP** : Aligner toutes les VM (pfSense, Wazuh, agents) sur une source NTP commune pour garantir la corrélation et la fiabilité forensique.
- [ ] **Sauvegardes** : Sauvegarder régulièrement `/var/ossec/etc` (incluant `local_rules.xml`) et le fichier `config.xml` de pfSense, puis tester la restauration.
- [ ] **Stockage & Rétention** : Configurer une politique ISM (*Index State Management*), superviser le remplissage disque (< 85 %) et exporter les archives compressées vers un stockage froid (NAS / WORM).
- [ ] **Gestion des versions** : Mettre à jour le Manager Wazuh avant les agents (dépôt APT désactivé sur les agents entre deux campagnes).
- [ ] **Auto-surveillance** : Alerter immédiatement sur tout agent passant à l'état `disconnected` (indicateur potentiel de tentative de neutralisation).
