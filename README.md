# Miss France Fun -- Jeu Mobile Flutter

Miss France Fun est une application mobile réalisée en **Flutter**,
permettant aux joueurs de noter les candidates du concours Miss France
et de tester leur capacité à prédire les différentes étapes du concours.

L'application n'est **pas commercialisée** et se veut bonne ambiance,
ludique et simple d'utilisation.

## 📱 Fonctionnalités principales

### 🔮 Étape 0 -- Pari initial

Le joueur choisit sa Miss favorite avant le début du concours.

### 👗 Étape 1 -- Défilé des 40 Miss

-   Notation sur 3 critères (ex. élégance, prestance, originalité).
-   Calcul automatique d'un score par Miss.
-   Sélection automatique des **20 meilleures**.

### ⭐ Étape 2 -- Saisie des 20 Miss officielles

-   Le joueur saisit les 20 Miss officiellement qualifiées.
-   Comparaison avec les 20 Miss sélectionnées automatiquement.
-   Attribution d'un score selon les correspondances.

### 💃 Étape 3 -- Défilé des 20 Miss

-   Nouvelle notation sur 3 critères.
-   Sélection automatique des **5 meilleures**.

### 👑 Étape 4 -- Saisie des 5 finalistes officielles

-   Le joueur saisit les 5 finalistes.
-   Nouvelle comparaison + score.

### 🏅 Étape 5 -- Défilé final des 5 Miss

-   Nouvelle notation.
-   Détermination automatique de la Miss France "pariée".

### 🎉 Étape 6 -- Élection de Miss France

-   Le joueur saisit la gagnante officielle.
-   Comparaison finale et calcul du score total.

## 🧮 Système de score

-   1 point par Miss correctement pronostiquée.
-   5 points bonus pour la gagnante.
-   Bonus si le pari initial est correct.

## 🏗️ Structure du projet

    /lib
      /screens
      /widgets
      /models
      /services
      main.dart
    /assets
      /images
      /icons

## 🚀 Installation

    git clone https://github.com/<ton-user>/<ton-repo>
    cd miss-france-fun
    flutter pub get
    flutter run

## 📜 Licence

Projet personnel et non commercialisé.
