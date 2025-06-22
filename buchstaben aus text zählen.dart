import 'dart:io';

main() {
  List<String> wordList = getUserInputWordlist();

  List<String> sortierliste = getUserInputCheckList();

  ausgabe(wordList, sortierliste);
}

Map<String, int> anzahlBuchstabenzaehlen(
  List<String> texte,
  List<String> sortierListe,
) {
  Map<String, int> newMap = {};

  for (int i = 0; i < sortierListe.length; i++) {
    if (!newMap.containsKey(sortierListe[i])) {
      newMap[sortierListe[i]] = 0;
    }
  }

  for (int i = 0; i < texte.length; i++) {
    String temp = texte[i];

    for (int j = 0; j < temp.length; j++) {
      if (sortierListe.contains(temp[j])) {
        newMap[temp[j]] = newMap[temp[j]]! + 1;
      }
    }
  }

  return newMap;
}

void ausgabe(List<String> texte, List<String> sortierliste) {
  for (int i = 0; i < texte.length; i++) {
    String wort = texte[i];
    Map<String, int> zaehlung = anzahlBuchstabenzaehlen([wort], sortierliste);

    int gesamt = zaehlung.values.fold(0, (summe, wert) => summe + wert);

    print("Das Wort '$wort' hat folgende Buchstaben: $zaehlung");
    print("→ Insgesamt gefundene Buchstaben im Wort: $gesamt\n");
  }
}

List<String> getUserInputWordlist() {
  List<String> liste = [];

  print("pls write in the Words you want to check splittet by ,\n\n\n\n\n\n");

  String Input = stdin.readLineSync() ?? "";

  Input = Input.toString();
  Input = Input.toLowerCase();
  Input = Input.trim();

  if (Input != Input.isEmpty) {
    liste = Input.split(",").toList();
  }

  return liste;
}

List<String> getUserInputCheckList() {
  List<String> liste = [];

  print("pls write in the Words you want to count splitet by , \n\n\n\n\n\n");

  String Input = stdin.readLineSync() ?? "";

  Input = Input.toString();
  Input = Input.toLowerCase();
  Input = Input.trim();

  if (Input != Input.isEmpty) {
    liste = Input.split(",").toList();
  }

  return liste;
}
