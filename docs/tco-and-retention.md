# Dimensionnement stockage & Analyse du TCO sur 3 ans

## 1. Politique de rétention (SSD 256 Go — 85 Go utiles OpenSearch)

Sur 100 Go alloués aux index Wazuh, le seuil de protection OpenSearch (*low watermark*) à **85 %** fixe la capacité utile à **85 Go** (passage en lecture seule à 95 %).

| Volume indexé / jour | Rétention chaude estimée | Profil correspondant |
| :--- | :---: | :--- |
| `0,5 Go/j` | ~170 jours | Maquette / très petit parc |
| `1,0 Go/j` | ~85 jours | Petit parc, collecte ciblée |
| `2,0 Go/j` | **~42 jours** | **Hypothèse BioSanté (40 postes, 2 serveurs, 1 pare-feu)** |
| `5,0 Go/j` | ~17 jours | Collecte étendue (logs pare-feu + accès web verbeux) |

## 2. Estimation comparative du TCO sur 3 ans

Hypothèses : volume de `2 Go/jour` (`730 Go/an`), coût journalier chargé technicien de `300 €/j`, exploitation à `0,5 j/semaine` (`23,5 j/an`), formation/veille `3 j/an`, énergie `30 W` à `0,25 €/kWh`.

| Poste de coût (3 ans) | SOC Wazuh auto-hébergé | Microsoft Sentinel (Pay-as-you-go) | SOC managé (MSSP / MDR) |
| :--- | :---: | :---: | :---: |
| **Licences / Abonnement** | `0 €` | `9 417 USD` *(4,30 USD/Go)* | Sur devis |
| **Matériel & Énergie** | `347,10 €` *(SSD 150 € + énergie)* | `0 €` | Selon l'offre |
| **Déploiement initial** | `3 000 €` *(10 j)* | `1 500 €` *(5 j)* | Souvent inclus |
| **Exploitation interne** | `21 150 €` *(70,5 j)* | `21 150 €` *(70,5 j)* | Réduite |
| **Formation & Veille** | `2 700 €` *(9 j)* | `2 700 €` *(9 j)* | Réduite |
| **Total 3 ans** | **`27 197,10 €`** | **`25 350 € + 9 417 USD`** | **Sur devis** |

> **Enseignement clé** : Dans le scénario Wazuh, **98,7 % du coût total** provient du temps humain. L'avantage économique majeur réside dans l'absence de facturation au volume : à `5 Go/jour`, la licence Sentinel passerait à `23 542,50 USD` sur 3 ans, alors que le surcoût de Wazuh se limite à l'extension disque.
