import 'SebiList.dart';

void main() {
  Sebilist<String> cromaticScale = createChromaticScale();
  print(cromaticScale);
}

Sebilist<String> createChromaticScale() {
  List<String> grundTone = ["c", "d", "e", "f", "g", "a", "h"];
  Sebilist<String> cromaticScale = new Sebilist();

  for (int i = 0; i < grundTone.length; i++) {
    cromaticScale.add(grundTone[i]);
    if (grundTone[i] == "c" ||
        grundTone[i] == "d" ||
        grundTone[i] == "f" ||
        grundTone[i] == "g" ||
        grundTone[i] == "a") {
      cromaticScale.add(grundTone[i] + "#");
    }
  }

  return cromaticScale;
}

Sebilist<String> createChord(String tone, String Mod) {
  Sebilist<String> Chord = new Sebilist();
  Sebilist<String> cromaticScale = createChromaticScale();
  int index = cromaticScale.SearchIndex(tone);
  int bterz = 4;
  int lterz = 3;
  int lastTone = 7;

  Chord.add(cromaticScale[index]);

  if (Mod == "moll") {
    Chord.add(cromaticScale[(index + lterz) % 12]);
    Chord.add(cromaticScale[(index + lastTone) % 12]);
  } else {
    Chord.add(cromaticScale[(index + bterz) % 12]);
    Chord.add(cromaticScale[(index + lastTone) % 12]);
  }

  return Chord;
}
