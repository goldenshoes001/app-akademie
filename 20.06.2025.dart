void main() {
  print("Summe aus 1,2,3: ${addition(1, 2, 3)}");
  print("Summe aus 4,5,6: ${addition(4, 5, 6)}");
  print("Summe aus 7,8,9: ${addition(7, 8, 9)}");

  print("laenge von hallo: ${laengeDesTextes("hallo")}");
  print("laenge von Welt: ${laengeDesTextes("welt")}");
  print("laenge von Sebastian: ${laengeDesTextes("Sebastian")}");

  print("anzahl vokale von aeiou ${anzahlVokale("aeiou")}");
  print("anzahl vokale von hallo ${anzahlVokale("hallo")}");
  print(
    "anzahl vokale von ich bin ein text ${anzahlVokale("ich bin ein text")}",
  );
}

int addition(int zahl1, int zahl2, int zahl3) {
  return zahl1 + zahl2 + zahl3;
}

int laengeDesTextes(String text) {
  return text.length;
}

int anzahlVokale(String text) {
  int anzahl = 0;
  text.toLowerCase();
  for (int i = 0; i < text.length; i++) {
    if (text[i] == "a" ||
        text[i] == "e" ||
        text[i] == "i" ||
        text[i] == "o" ||
        text[i] == "u") {
      anzahl++;
    }
  }

  return anzahl;
}
