TD Docker – API, Frontend et PostgreSQL

Ce projet constitue une stack Docker complète comprenant :

une API Node.js (Express) ;

une base de données PostgreSQL ;

un frontend statique (HTML/JavaScript) servi via Nginx.

L’ensemble est orchestré grâce à Docker Compose, avec réseau dédié, volumes persistants et healthchecks.

1. Démarrage du projet
Prérequis

Docker Desktop installé

Docker Compose (inclus dans Docker Desktop)

Git

Lancement de la stack

Cloner le projet :
```
git clone https://github.com/J0r3lle/TD-Docker/.git
cd TD-Docker
```


Démarrer les conteneurs :
```
docker compose up -d --build
```

Vérifier l’état des services :
```
docker compose ps
```
2. Accès aux services

Frontend : http://localhost:8080

API (statut) : http://localhost:3000/status

API (items) : http://localhost:3000/items

3. Architecture générale
```
   frontend (Nginx)
        |
        v
   API (Node.js)
        |
        v
   PostgreSQL (DB)
```

Le frontend communique avec l’API via un reverse proxy Nginx (/api).

L’API interagit avec PostgreSQL pour récupérer les données.

Les trois services sont isolés dans un réseau Docker nommé app-net.

Les données de la base sont persistées via le volume Docker db_data.

4. Structure du projet

```
.
├── api/
│   ├── src/
│   │   ├── index.js
│   │   └── db.js
│   ├── Dockerfile
│   └── package.json
├── frontend/
│   ├── src/
│   │   ├── index.html
│   │   └── app.js
│   ├── Dockerfile
│   └── nginx.conf
├── db/
│   └── init.sql
├── docker-compose.yaml
└── README.md
```

6. Contenu technique
API Node.js

Framework : Express

Connexion à PostgreSQL via pg

Endpoints disponibles :

GET /status : indique le statut de l’API

GET /items : retourne les données de la table items

Base de données PostgreSQL

Initialisée automatiquement via le script db/init.sql

Volume persistant : db_data

Healthcheck intégré dans Docker Compose

Frontend Nginx

Pages statiques servies depuis /usr/share/nginx/html

Reverse proxy :

/api → api:3000

6. Sécurité et vulnérabilité identifiée

Lors du scan de l’image Node.js, une vulnérabilité de sévérité 7.5 a été signalée concernant la bibliothèque npm glob.

Analyse effectuée :

Le module glob est présent uniquement en tant que dépendance transitive.

Le projet n’utilise ni directement ni indirectement glob.

Aucun appel à glob n’est effectué dans le code de l’API.

La vulnérabilité ne s’applique donc pas au fonctionnement réel de l’application.

Décision :

Le module ne sera pas utilisé dans le code tant qu’une version totalement corrigée n’est pas stabilisée.

La vulnérabilité est considérée comme connue, documentée et non-impactante dans le contexte du projet.

7. Utilisation de l’intelligence artificielle

L’intelligence artificielle (ChatGPT) a été utilisée comme outil d’assistance pour :

clarifier certaines étapes du projet ;

proposer des améliorations de structure et de configuration ;

résoudre des erreurs techniques liées à Docker ou Nginx ;

assister dans la rédaction du README et du rapport associé.

Les développements, tests, validations et configurations finales ont été réalisés manuellement.

8. Licence

Projet pédagogique. Libre de consultation et de réutilisation dans le cadre académique.
