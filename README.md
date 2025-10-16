# Dating Application

Cette application est une application de rencontres développée avec Ruby on Rails.

## Configuration Requise

* Ruby version: 3.1.7
* Rails version: 7.1.5
* Base de données: MySQL

## Technologies Utilisées

* Ruby on Rails 7.1.5
* MySQL (via mysql2 gem)
* Hotwire (Turbo Rails)
* Stimulus.js
* Tailwind CSS (via cssbundling-rails)
* JavaScript bundling (via jsbundling-rails)

## Installation

1. Cloner le dépôt

2. Installer les dépendances Ruby et JavaScript:
   ```bash
   bundle install
   # si vous utilisez yarn
   yarn install
   # ou avec npm
   # npm install
   ```

3. Configuration de la base de données

   Le projet utilise MySQL. Le fichier `config/database.yml` contient la configuration suivante (extrait) :

   ```yaml
   default:
     adapter: mysql2
     encoding: utf8mb4
     pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
     username: root
     password: louise
     socket: /var/run/mysqld/mysqld.sock

   development:
     <<: *default
     database: dating_development

   test:
     <<: *default
     database: dating_test

   production:
     <<: *default
     database: dating_production
     username: dating
     password: <%= ENV["DATING_DATABASE_PASSWORD"] %>
   ```

   Notes importantes :
   - En développement et test, le README reflète la configuration actuelle : user `root`, mot de passe `louise` et socket `/var/run/mysqld/mysqld.sock`.
   - En production, la variable d'environnement `DATING_DATABASE_PASSWORD` doit être définie pour sécuriser le mot de passe. Ne stockez jamais de secrets en clair dans le dépôt.

   Commandes utiles :
   ```bash
   # création et migration de la base
   rails db:create
   rails db:migrate

   # pour exécuter les seeds si présents
   rails db:seed
   ```

   Si MySQL n'est pas démarré sur votre machine Linux :
   ```bash
   sudo service mysql start
   # ou
   sudo systemctl start mysql
   ```

## Lancer l'application

## Lancer l'application

Pour lancer l'application en développement (utilise `Procfile.dev` via `foreman`):

```bash
# rendu présent dans le projet — lance les processus définis dans Procfile.dev
bin/dev
```

Le `Procfile.dev` contient :
```
web: env RUBY_DEBUG_OPEN=true bin/rails server
css: yarn build:css --watch
```

L'application sera accessible à l'adresse http://localhost:3000

## Tests

Pour exécuter la suite de tests:
```bash
rails test
```

## Configuration par variables d'environnement

L'application utilise des variables d'environnement pour sa configuration. Un fichier `.env.example` est fourni comme modèle :

```bash
# Copier le fichier exemple
cp .env.example .env

# Éditer le fichier avec vos valeurs
nano .env  # ou votre éditeur préféré
```

Variables d'environnement disponibles :

```bash
# Base de données
DATING_DATABASE_USERNAME=root          # utilisateur MySQL
DATING_DATABASE_PASSWORD=change_me     # mot de passe
DATING_DATABASE_HOST=localhost         # hôte (optionnel)
DATING_DATABASE_SOCKET=/var/run/mysqld/mysqld.sock  # socket Unix

# Rails
RAILS_MAX_THREADS=5                   # nombre de threads Puma
RAILS_ENV=development                 # environnement Rails
PORT=3000                            # port du serveur
```

## Sécurité et bonnes pratiques

* Ne commitez jamais le fichier `.env` contenant vos secrets
* En production, utilisez :
  - les `credentials` de Rails (`rails credentials:edit`) pour stocker des secrets chiffrés
  - ou les variables d'environnement gérées par votre plateforme de déploiement
* Pour le développement local :
  - Utilisez le fichier `.env` (non commité)
  - Ou `direnv` pour une gestion automatique des variables par projet

## Sujets à vérifier après le lancement

* Créer un utilisateur de base de données dédié pour la production (il est déjà prévu dans `config/database.yml` : user `dating`).
* Vérifier que MySQL accepte la connexion via le socket `/var/run/mysqld/mysqld.sock` (ou adaptez `host: localhost` si nécessaire).
* Ajouter des instructions de déploiement spécifiques à l'infrastructure cible (Heroku, Docker, etc.)

* Deployment instructions

* ...

* Deployment instructions

* ...
