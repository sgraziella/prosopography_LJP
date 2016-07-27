# Prosopography
*Work in progress*

This is a digital repository of autority files related to this project [http://josticeetplet.huma-num.fr/](http://josticeetplet.huma-num.fr/), developped by CMS [Omeka](https://omeka.org/).

The XSL transformation included in this repository are useful in order to manage by Omeka a simple cycle of Importing/Exporting biographical and/or historical information about the entity being described as standard format ([EAC-CPF](http://eac.staatsbibliothek-berlin.de/index.php), [TEI](http://www.tei-c.org/release/doc/tei-p5-doc/en/html/ref-person.html), etc.)

For more information visit:
- [http://josticeetplet.huma-num.fr/](http://josticeetplet.huma-num.fr/)
- [ExportEacCpf](https://github.com/sgraziella/ExportEacCpf)


### Contents:
*French version*

Pour le moment, ce dossier contient : 

- les notices du corpus encodées en XML/EAC-CPF placés sous licence libre, selon les termes de la licence Creative Commons Attribution-ShareAlike 4.0 International (CC BY-SA 4.0);
- le schéma EAC-CPF (fichier cpf.xsd) et les deux schémas que ce schéma principal importe (fichiers xlink.xsd et xml.xsd) publiés par le groupe AFNOR CG/46/CN357/GE4 dans le dossier des exemples de notices XML/EAC-CPF (nb: pour que l'éditeur XML puisse valider ces notices, il faut que les notices et les schémas soient placés dans le même dossier).
- des dossiers contenant des transformations XSLT permettant de créer un fichier intermediaire XML simple pour ensuite permettre le passage en CSV (EAC-CPFtoXML, TEItoXML, etc.);
- un dossier avec des transformations de base de TEI vers EAC-CPF.

