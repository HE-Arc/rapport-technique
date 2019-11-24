---
title: Rapport technique
subtitle: Avec _Markdown_ et l'aide de _pandoc_
lang: fr
author:
- Yoan Blanc^[yoan@dosimple.ch]
tags: [markdown, pandoc]
date: \today
papersize: a4

# Modèle
#documentclass: scrreprt
documentoptions: twoside

# Styles
fontsize: 12pt
colorlinks: true
linkcolor: Blue
citecolor: MidnightBlue
urlcolor: MidnightBlue

links-as-notes: true
numbersections: true

#mainfont: Linux Libertine O
#sansfont: Linux Biolinum O
#monofont: Inconsolata
monofontoptions: Scale=.8

# Table des matières
toc: true
toc-depth: 1
lof: true
lot: true
tblPrefix: tab
lolTitle: Liste des extraits de code

# Sources
bibliography: bibliographie.bib
csl: iso690-author-date-fr.csl

# Abstract, thanks, etc.
abstract: |
    _This document aims at presenting how to build a technical report respecting the guidelines set by the_ Haute-École Arc _using open source softwares and the_ Markdown _format._

    _**Keywords:** pandoc, markdown._

    ---

    Ce document présente sommairement comment construire un document respectant les critères de la Haute-École Arc à l'aide de logiciels libres et du format _Markdown_.

    **Mots-clés:** pandoc, markdown.

# https://tex.stackexchange.com/questions/7546/how-to-get-latex-symbol-in-document/7549#7549
header-includes:
- |
  \usepackage{lmodern}
  \usepackage{xspace}
  \usepackage{xltxtra}
  \let\tex\TeX
  \renewcommand{\TeX}{\tex\xspace}
---

\listoflistings

# Introduction

Traditionnellement, les outils d'édition de rapport privilégiés des étudiants sont _Microsoft Word_ ou _LibreOffice Writer_. D'aucuns, plus courageux, se lancent dans \LaTeX à l'aide d'un éditeur riche comme [_LyX_](https://www.lyx.org/) ou, l'éditeur en ligne qu'est [_ShareLaTeX_](https://www.sharelatex.com/).

L'approche présentée ici se place entre ces deux univers. _Markdown_ est un format très facile à prendre en main, partagés, et [_pandoc_][pandoc] offre une conversion vers PDF qui fonctionne. Les limitations de _Markdown_ impliquent de recourir à d'autres outils pour gérer la bibliographie ou les références.

Cette approche a été utilisée pour le support du cours de troisième année [Développement Web](https://he-arc.github.io/slides-devweb/), ainsi que par d'anciens étudiants fraichement diplômés.

## Rapport technique

Selon les directives de l'école [@arc2017], les difficultés d'un rapport technique au niveau de sa structure sont de réaliser correctement les éléments suivants:

- page de titre;
- table des matières;
- liste des figures, tableaux et/ou équations;
- _abstract_, introduction et conclusion;
- le fameux SPRI [@timbal1982communication], ou IMMRID (voir le [glossaire](#glossaire));
- et la bibliographie.


Parmi ceux-ci, les gros morceaux requièrent un gros investissement en terme de rédaction. Mais également, un travail d'organisation et de documentation très fin. Si constituer une bibliographie via [Zotero](https://zotero.org/), [BibDesk](http://bibdesk.sourceforge.net/), ou autre, est relativement aisé; gérer les citations, références et formater le tout correctement peut être fastidieux. Tout comme documenter et référencer chaque image, équation ou table de données. Et c'est sans parler que c'est un travail de groupe dont il faut également coordonner les diverses contributions.

## Markdown

L'idée est de reposer sur un format de fichier textuel, similaire à HTML mais avec une syntaxe plus légère. _Markdown_ est inspiré d'un formalisme apparu _de facto_ dans les listes de diffusion d'e-mails.

Ce format semi-structuré est devenu au fil des ans le favori des *geeks*. HTML étant trop fastidieux, ils n'ont eu de cesse d'imaginer des alternatives pour permettre l'édition de pages web au plus grand nombre, notamment au travers des *wikiwikiwebs* (ou simplement *wikis*), tel que _Wikipedia_.

> _"A Markdown-formatted document should be publishable as-is, as plain text, without looking like it's been marked up with tags or formatting instructions."_
>
> -- John Gruber


```markdown
<!-- ceci est un commentaire -->

# Titre 1
## Titre 2
### Titre 3
#### Titre 4
##### Titre 5
###### Titre 6

*emphase* ou _emphase_ (affiché en italique)

**forte emphase** ou __forte emphase__ (affiché en gras)


- liste
- non
- ordonnée


1. liste
2. ordonnée


liste

: de définition


[lien hypertext](https://example.org)

![texte alternatif](image.png)

> citation

    texte non-formaté

```

L'avantage à utiliser du texte est qu'il est aisé à versionner (`svn`, `git`, etc.) et qu'il sépare les tâches de rédaction et de mise en forme. Notre cerveau, en mode écriture, est ainsi libre dans sa créativité et ne s'occupe pas de la mise en page.

_GitHub_ est un grand utilisateur du format _Markdown_ et propose un [guide utile](https://guides.github.com/features/mastering-markdown/) à son apprentissage. En matière d'édition collaborative, [_HackMD.io_](https://hackmd.io/new) propose un système proche de _Google Docs_.

### Formules mathématiques

Il est même possible de faire des tables HTML et même des formules mathématiques grâce à [MathJax](https://www.mathjax.org/).

$$-1 = e^{j \pi}$${#eq:minus-one}

Le format utilisé est celui de \LaTeX. Avec un signe dollar (`$`) pour une formule en ligne, par exemple $e^{j \pi}$. Et deux `$$` pour une formule centrée sur sa propre ligne (telle que @eq:minus-one).

```markdown
$$-1 = e^{j \pi}$$
```

### Méta-données

Ce qu'il manque à Markdown est d'être capable de renseigner des informations à propos du contenu: des *métadonnées*. Le moyen de faire ceci est d'utiliser un prologue dans autre format, nommé YAML. Le prologue YAML est enfermé dans deux triple-tirets `---`.

```yaml
---
title: Mon titre
lang: fr
---

... mon rapport technique ...

```

Ici, nous avons renseigné des informations permettant de construire la page de titre du rapport, ainsi que d'appliquer les règles de formatage typographiques propre au français (`fr`).

## Pandoc

Un logiciel très puissant issu du temps libre d'un certain John MacFarlane, professeur de psychologie à l'université de Berkeley. Supportant pléthore de formats différents, il est capable de les convertir de l'un à l'autre selon la table ci-dessous (@tbl:input-output).

| entrée | sortie |
|--------|--------|
| docbook, docx, epub, html, \LaTeX, markdown, mediawiki, odt, rst, textile, twiki, ... | **idem** + beamer, dzslides, epub3, html5, pdf, revealjs, rtf, s5, slideous, slidy, ... |


: formats d'entrée et de sortie. {#tbl:input-output}

La liste complète des options à disposition se trouve dans l'aide de la commande.

```bash
$ man pandoc
```

### Alternatives et variantes

S'il est possible de tout faire avec *Pandoc*, un usage intermédiaire est envisageable où le squelette du rapport est réalisé avec \LaTeX et le contenu des différentes sections écrit en Markdown pour des raisons de simplicité. Un template pour la HES-SO a été créé par [Marc Demierre](https://github.com/mdemierre/hesso-latextemplate-thesis) et peut servir de base.

[Sphinx][sphinx] est une bonne alternative si le but est de produire une documentation technique en lien avec un code source.

## Installation

Se lancer dans la production de document PDF avec \LaTeX demande de télécharger la moitié d'Internet et peut être déroutant.

La suite des opérations est prévue pour fonctionner sous Ubuntu ainsi que Ubuntu sous Windows (aussi nommé WSL (*Windows Subsystem for Linux*) disponible sous Windows 10 via le _Store_). Elle a été testée dans l'environnement suivant:

```bash
$ lsb_release -a
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.3 LTS
Release:        16.04
Codename:       xenial
```

Depuis un terminal, installez quelques dépendances à l'aide d'`apt`.

```bash
$ sudo apt install \
    pandoc \
    pandoc-citeproc \
    texlive-fonts-extra \
    texlive-lang-english \
    texlive-lang-french \
    texlive-math-extra \
    texlive-xetex \
    ttf-mscorefonts-installer
```

Quoi est quoi?

- `\` évite de tout avoir sur seule ligne, c'est une astuce pour mettre de longues commandes dans un fichier imprimable tel que celui-ci;
- `pandoc` convertit des formats textes en d'autres, ici de _Markdown_ vers \LaTeX;
- `pandoc-citeproc` gère les citations et la bibliographie;
- `texlive-fonts-extra` plein de polices de caractères;
- `texlive-lang-english` les bouts de code source seront en anglais;
- `texlive-lang-french` notre contenu sera en français;
- `texlive-math-extra` affichage des formules mathématiques;
- `texlive-xetex` un meilleur support des polices et de l'Unicode;
- `ttf-mscorefonts-installer` pour ceux qui veulent utiliser les polices Windows (Comic Sans, Impact, ...).

### Pandoc 2

Les versions fournies avec Ubuntu Xenial (16.04) sont un peu vieilles. Une alternative est d'installer `pandoc` (et `pandoc-citeproc`) directement depuis [GitHub](https://github.com/jgm/pandoc/releases).

```bash
$ wget https://github.com/jgm/pandoc/releases\
> /download/2.1.3/pandoc-2.1.3-1-amd64.deb

$ sudo dpkg -i pandoc-2.1.3-1-amd64.deb

$ pandoc -v
pandoc 2.1.3
...
```

**NB :** les exemples suivants partent du principe que vous avez installés _Pandoc_ version 2.

# Réalisation

Une fois le langage de description _Markdown_ apprivoisé, il va s'agir de réussir la génération d'un document PDF. Puis nous y incluerons les éléments importants du rapport technique tels que la bibliographie, table des matières, les références, et la page de titre.

## Le B.a.-ba

À partir d'un document Markdown, ici nommé `rapport.md`, nous pouvons débuter.

```bash
$ pandoc rapport.md --to latex
```

Le contenu est transformé selon le formalisme \LaTeX. Et seulement, le contenu. Le drapeau `--standalone` permet d'en faire un document complet.

```bash
$ pandoc rapport.md \
    --standalone \
    --to latex
```

La commande suivante le transformera, avec un peu de chance, en document PDF. Le moteur de rendu est à spécifier, ici \XeLaTeX.

```bash
$ pandoc rapport.md \
    --standalone \
    --to latex \
    --pdf-engine xelatex \
    --output rapport.pdf
```

Le détail de chaque drapeau:

- `--standalone` ajoute les entête et pied au document. Sinon, seul le contenu est produit;
- `--to latex` décrit que le format de sortie désiré est \LaTeX;
- `--pdf-engine xelatex` pour un meilleur support des polices (OTF, TTF, etc.) et de l'Unicode;
- `--output rapport.pdf` le nom du fichier de sortie.

### Page de titre

_Markdown_ ne peut s'occuper que du contenu. Donc il est nécessaire de passer par le prologue _YAML_ du fichier.

```yaml
---
title: My awesome project
lang: en
author:
- Yoan Blanc <yoan@dosimple.ch>
- Marc Schaefer <marc.schaefer@he-arc.ch>
date: \today
pagesize: A4
---
```

### Table des matières

Le format \LaTeX contient des macros permettant de produire une superbe table des matières. Il suffit de l'activer dans le prologue.

```yaml
---
toc: true
toc-depth: 5
---
```

### Mise en forme

Avec quelques options de base, il est déjà possible d'obtenir un résultat intéressant. Pour aller plus loin, s'intéresser au fonctionnement des templates \LaTeX devient indispensable.

```yaml
---
fontsize: 14pt
documentclass: scrreprt
documentoptions: twoside
numbersections: true
---
```

Les styles de base tels que `article`, `report` et `book` ont leur pendant dans la bibliothèque [Koma-Script](https://www.ctan.org/pkg/koma-script) avec `scrartcl`, `scrreprt` et `scrbook`. Koma est assez populaire car son rendu est de bonne facture.

### Polices de caractères et couleurs

Les polices de caractères Microsoft (`ttf-mscorefonts-installer`) sont installées. Il est possible de s'en servir et de pouvoir ressembler à un document produit avec Microsoft Word.

```yaml
---
colorlinks: blue
mainfont: Times New Roman
sansfont: Arial Black
monofont: Andale Mono
monofontoptions: Scale=0.8  # Pour ceux qui écrivent en Java
                            # c'est peut-être encore trop grand.
---
```

Sous GNU/Linux, les polices sont généralement installées dans `/usr/share/fonts`. Et `apt` permet d'en installer tout un tas d'autres de bonne facture via `texlive-fonts-extra`. La famille [Linux Libertine](http://www.linuxlibertine.org/) est utilisée dans ce document.


## Bibliographie avec _pandoc-citeproc_

Le format \LaTeX possède un outil, ou de nombreux outils, permettant de gérer les bibliographies. _pandoc-citeproc_ en supporte plusieurs dont Bib\LaTeX, le format généralement utilisé avec \LaTeX.

```yaml
---
bibliography: bibliographie.bib
---

Création de la référence [@arc2017].
```

**NB:** Pour qu'un élément apparaisse dans la bibliographie, il est nécessaire qu'il soit cité dans le corps du document.

```bash
$ pandoc rapport.md \
    --filter pandoc-citeproc \
    ...
```

Un moyen simple de créer son fichier `.bib` (par exemple [@lst:bibliographie]) est d'utiliser un logiciel permettant de collecter les références bibliographiques tel que _Zotero_ ou de les exporter via [_Google Scholar_](https://scholar.google.fr/intl/fr/scholar/help.html#export).

```{#lst:bibliographie .bibtex caption="bibliographie.bib"}
@article{arc2017,
  title={Communication I : le rapport technique},
  author={Perret, Michael and Raboud, Stéphane and Babey, Magali},
  year={2017}
}
```

### Style de la bibliographie

Pandoc utilise le style dit _Chicago_ [@webster2017chicago] car très populaire dans les sciences humaines. Il ne l'est pas forcément au sein des sciences de l'ingénierie.

Les styles de bibliographie sont nombreux et donc interchangeables d'une plateforme de publication à l'autre. [_CitationsStyles_](https://www.citationstyles.org) permet de décrire le format de la bibliographie et des citations. Vous trouverez des styles à choix sur le [_Zotero Style Repository_](https://www.zotero.org/styles/). Le format francophone et le style _ISO 690_ sont recommandés par l'école.

```yaml
---
bibliography: README.bib
csl: iso690-author-date-fr.csl
---
```

## Références avec _pandoc-crossref_

Dans un document scientifique, il est recommandé de numéroter et référencer toutes les figures, et tables de données. Une tâche qui est un peu fastidieuse. Elle devient presque aisée à l'aide d'un outil comme [_pandoc-crossref_](https://github.com/lierdakil/pandoc-crossref).

```bash
$ wget https://github.com/lierdakil/pandoc-crossref/releases\
> /download/v0.3.0.0-beta3/linux-ghc8-pandoc-2-0.tar.gz

$ tar xf linux-ghc8-pandoc-2-0.tar.gz
$ sudo mv pandoc-crossref /usr/local/bin
```

Il est important d'exécuter le filtre des références **avant** celui des citations.

```bash
$ pandoc rapport.md \
    --filter pandoc-crossref \
    --filter pandoc-citeproc \
    ...
```

![Le trombone de Microsoft Word "Clippy" tout triste](sad-clippy.jpg){#fig:clippy}

Ensuite, référencer une image telle que le *Clippy* triste (@fig:clippy, © 2016 [Joana Afonso](http://joanaafonso.com)) se fait ainsi:

```markdown
Un paragraphe décrivant l'illustration (@fig:id).

![légende](fichier.jpg){#fig:id}
```

En \LaTeX, afficher la table des figures se fait via `\listoffigures`, qui existe au sein du prologue avec `lof` (et `lot` pour `\listoftables`).

```yaml
---
lof: true   # table des figures
lot: true   # liste des tableaux
---
```

ou, en \LaTeX directement pour contrôler leur place et/ou leur ordre dans le document.

```latex
\listoffigures
\listoftables
\listoflistings    # `lol` n'existe pas dans pandoc.
```

Les options sont expliquées dans la page manuelle de la commande elle-même.

```bash
$ pandoc-crossref --man
```

## Étendre _pandoc_

Il est possible de modifier le format produit par pandoc à l'aide de filtres en Haskell (le langage de Pandoc), Lua (Pandoc 2) ou Python (`pandoc-filters`).

### Exemple: les problèmes liés au français

La bibliothèque gérant les langues va nous fournir des corrections adaptées à la langue choisie. Comme nous écrivons en français, elle va, entre autres, ajouter un espace insécable devant certains éléments de ponctuation tels que le deux-points (:), le point-virgule (;). Et elle s'occupe également de modifier l'apostrophe, et les "guillemets". Choses qui ne sont pas désirées lorsqu'il s'agit de code source.

Le filtre (@lst:english) écrit en Lua change la langue utilisée dans les blocs de code. S'en servir est aussi simple qu'avec les autres filtres.

```bash
$ pandoc rapport.md \
    --lua-filter english.lua \
    --filter pandoc-crossref \
    --filter pandoc-citeproc \
    ...
```

Sans ceci, tous les exemples contenant ces éléments de ponctuation seraient cassés. C'est un usage très avancé, que les plus informaticiens d'entre vous sauront dompter.

```{#lst:english .lua .numberLines caption="english.lua"}
local lang = 'en'

return {
  {
    Code = function(el)
      return pandoc.Span(el, pandoc.Attr("", {}, {lang = lang}))
    end,

    CodeBlock = function(el)
      return pandoc.Div(el, pandoc.Attr("", {}, {lang = lang}))
    end,
  }
}
```

# Conclusion

Réaliser le rapport technique d'un projet de semestre, de diplôme, seul ou en groupe est un gros investissement en énergie. C'est parfois l'élément du projet qui est sous-estimé par les étudiants. _Markdown_ est un format suffisamment simple pour permettre la prise de note tout au long du projet. Il est possible d'en faire l'édition en ligne aisément voire même de collaborer en même temps sur un document.

Pandoc est ensuite la baguette magique transformant tout ceci en un document de bonne facture. Avec l'avantage d'être progressif. Un document \LaTeX demande un investissement relativement important d'apprentissage, mais permet beaucoup plus d'options. Et à l'inverse Microsoft Word est trop laxiste, n'imposant pas une structure forte dès le départ rendant les modifications futures complexes.

Le but de ce document est de servir de base pour correspondre aux attentes de la Haute-École Arc. Il est améliorable sous de nombreux aspects et reste suffisamment ouvert afin de permettre un peu de créativité.

La source de ce document se trouve sur <https://github.com/HE-Arc/rapport-technique>. Faites-en bon usage!

# Annexes {-}

## Glossaire {-}

IMMRID

: Introduction, Matériel, Méthode, Résultats, Interprétation, et Discussion. Méthode de structuration adaptée à un projet de recherche.

\LaTeX

: Un langage de description destiné à la production de documents techniques et scientifiques. <https://www.latex-project.org/>

Lua

: Un langage de programmation léger et généralement embarqué pour étendre une application. <https://www.lua.org/>

Python

: Un langage de programmation impératif, facile, ludique, et populaire. <https://python.org>

SPRI

: Situation, Problème, Résolution, et Informations. Une méthode permettant structurer un plan de présentation et introduite par Louis Timbal-Duclaux.

WSL

: _Windows Subsystem for Linux_ une plateforme permettant de faire fonctionner des logiciels GNU/Linux sur le système Windows sans passer par une machine virtuelle. <https://msdn.microsoft.com/en-us/commandline/wsl/about>

YAML

: _YAML Ain't a Markup Language_ un format de description structuré n'étant pas XML. <https://yaml.org>

## Sources {-}

<!-- liens raccourcis -->

[pandoc]: https://pandoc.org/
[sphinx]: https://sphinx.org/
