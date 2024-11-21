# 🍺 Application de Gestion des Bières Artisanales

## Contexte du Projet

Ce projet vise à créer une application permettant aux utilisateurs de découvrir, noter et organiser des bières artisanales. L'application permettra aux utilisateurs de sauvegarder leurs bières préférées, de laisser des avis, de visualiser des photos et d'explorer les différentes brasseries, catégories de bières et ingrédients utilisés dans la fabrication des bières.

L'application est construite avec une base de données PostgreSQL pour gérer toutes les informations relatives aux utilisateurs, bières, catégories, brasseries, avis, favoris, photos et ingrédients.

## Prérequis

Avant de pouvoir utiliser l'application, vous devez avoir installé les éléments suivants sur votre machine :

- 🐳 **[Docker](https://www.docker.com/get-started)** : Docker permet de créer des environnements isolés pour vos applications et services.
- 📦 **[Docker Compose](https://docs.docker.com/compose/install/)** : Outil qui permet de définir et exécuter des applications multi-conteneurs Docker.
- 🐘 **[PostgreSQL](https://www.postgresql.org/download/)** : Système de gestion de base de données relationnelle utilisé pour stocker les données du projet.
- 🧑💻 **[DBeaver](https://dbeaver.io/download/)** : Client SQL pour interagir avec votre base de données PostgreSQL.

## Installation

### 1. Clonez le dépôt

Clonez ce projet sur votre machine locale :

```bash
git clone https://github.com/2024-devops-alt-dist/zythologue-AM

```

### 2. Configurer l'environnement

Avant de démarrer l'application, vous devez créer un fichier `.env` à la racine de votre projet pour définir les identifiants de votre base de données PostgreSQL. 

1. **Créer le fichier `.env`**

   Dans le répertoire racine de votre projet, créez un fichier `.env`.

2. **Définir les variables d'environnement**

   Ajoutez les lignes suivantes dans votre fichier `.env` :

   ```env
    POSTGRES_USER=mon_user
    POSTGRES_PASSWORD=mon_mdp
    POSTGRES_DB=ma_bdd
    ``` 
   

3. ** Ajouter le `.env` dans le gitignore**

    Pour éviter que vos identifiants sois sur github, vous devez mettre le fichier `.env` dans le gitignore comme ceci :

    ```bash
    echo .env >> .gitignore
    ```

4. Demarrer l'applications avec Docker Compose

Une fois le fichier `.env` configuré et ajouté au .gitignore, vous devez démarrer les services définis dans votre projet avec Docker Compose.

La commande a faire dans `bash` :

```bash
docker-compose up -d
```

 Pour vérifier que le conteneur sois bien actif aller sur docker Desktop ou taper la commande dans `bash` :


 ```bash
 docker-compose ps
```
---
# Requêtes SQL

## 1 - Lister les bières par taux d'alcool, de la plus légère à la plus forte
```sql
SELECT * 
FROM beer
ORDER BY abv ASC
```

## 2 - Afficher le nombre de bières par catégorie.
```sql
SELECT 
    c."name" AS category_name, 
    COUNT(cb.id_beer) AS beer_count
FROM 
    category c
JOIN 
    category_beer cb 
ON c.id = cb.id_category
GROUP BY 
    c."name"
```

## 3 - Trouver toutes les bières d'une brasserie donnée.
```sql
   select 
     b."name" as beer_name,
     br."name" as brewery_name
 from 
     beer b
 join
     brewery br
 on br.id = b.id_brewery
 where br."name" = 'Nom_de_la_brasserie'
```

## 4 - Lister les utilisateurs et le nombre de bières qu'ils ont ajoutées à leurs favoris.
```sql
 SELECT 
    u."name" AS user_name, 
    COUNT(f.id_beer) AS favorite_count
FROM
    "user" u
LEFT JOIN
    favorite f
ON u.id = f.id_users
GROUP BY u."name"
```

## 5 - Ajouter une nouvelle bière à la base de données.
```sql
 INSERT INTO beer (name, description, abv, price, id_brewery)
VALUES
    ('name', 'Description', abv, price, id_brewery),
```

## 6 - Afficher les bières et leurs brasseries, ordonnées par pays de la brasserie.
```sql
SELECT
    b.name AS beer_name,
    br.name AS brewery_name,
    br.country AS brewery_country
FROM
    brewery br
JOIN
    beer b
ON br.id = b.id_brewery
ORDER BY br.country asc;
```

## 7 - Lister les bières avec leurs ingrédients.
```sql
SELECT b."name" AS beer_name,
i."name" AS ingredient,
i.type as ingredient
FROM
    beer b
JOIN 
    ingrdient_beer ib 
ON b.id = ib.id_beer
JOIN
    ingredient i
ON i.id = ib.id_ingredient;
```
## 8 - Afficher les brasseries et le nombre de bières qu'elles produisent, pour celles ayant plus de 5 bières.
```sql
SELECT 
    br.name AS brewery_name,
    COUNT(b.id) AS beer_count
FROM 
    brewery br
JOIN 
    beer b
ON 
    br.id = id_brewery 
GROUP BY 
    br.id, br.name
HAVING 
    COUNT(b.id) >= 2;
```

## 9 - Lister les bières qui n'ont pas encore été ajoutées aux favoris par aucun utilisateur.
```sql
SELECT b.id, b.name
FROM beer b
LEFT JOIN favorite f ON b.id = f.id_beer 
WHERE f.id_users IS NULL;
```

## 10 - Trouver les bières favorites communes entre deux utilisateurs.
```sql
SELECT DISTINCT b.id, b.name
FROM favorite f1
JOIN favorite f2 ON f1.id_beer = f2.id_beer
JOIN beer b ON b.id = f1.id_beer
WHERE f1.id_users = 1 AND f2.id_users = 2;

```

## 11 - Afficher les brasseries dont les bières ont une moyenne de notes supérieure à une certaine valeur.
```sql
SELECT br.name AS brewery_name, AVG(rating) AS rating
FROM brewery br
JOIN beer b ON br.id = b.id_brewery 
JOIN review r ON b.id = r.id_beer
GROUP BY br.id, br.name
HAVING AVG(rating) > 4.0;
```

## 12 - Mettre à jour les informations d'une brasserie.
```sql
UPDATE brewery
SET 
    name = 'Nouveau nom',
    country = 'Nouveau pays',
    description = 'Nouvelle description',
    adress = 'Nouvelle adresse',
WHERE id = 'id de la brasserie a modifier';
```


## 13 - Supprimer les photos d'une bière en particulier.
```sql
delete from photos 
where id_beer = "Id_biere_a_supprimer";		
```