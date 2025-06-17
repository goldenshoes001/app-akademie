import 'SebiList.dart';

void main() {
  Sebilist<String> chromatischeTonleiter = chromatischeTonleiterErstellen();
  print(chromatischeTonleiter);
}

Sebilist<String> chromatischeTonleiterErstellen() {
  List<String> grundTone = ["c", "d", "e", "f", "g", "a", "h"];
  Sebilist<String> chromatischeTonleiter = new Sebilist();

  for (int i = 0; i < grundTone.length; i++) {
    chromatischeTonleiter.add(grundTone[i]);
    if (grundTone[i] == "c" ||
        grundTone[i] == "d" ||
        grundTone[i] == "f" ||
        grundTone[i] == "g" ||
        grundTone[i] == "a") {
      chromatischeTonleiter.add(grundTone[i] + "#");
    }
  }

  return chromatischeTonleiter;
}
