import 'SebiList.dart';
import "dart:math";
import 'dart:io';

List<String> programmnames = [
  "chord",
  "scale",
  "intervall",
  "findkey",
  "transpose",
  "findChords",
];
List<Function> functions = [
  createChord,
  createScale,
  calculateIntervalFromTwoTones,
  findkey,
  transpose,
  findChords,
];

void main() {
  chooseProgramm();
}

Sebilist<String> findChords(Sebilist<String> toneList) {
  Sebilist<String> foundChords = new Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  // Keine Sortierung oder Duplikatsprüfung für toneList, da Sebilist das intern verwaltet

  // Iteriere durch jeden möglichen Grundton der chromatischen Skala
  for (int i = 0; i < chromaticScale.length(); i++) {
    String rootTone = chromaticScale[i];

    // Versuche, einen Dur-Akkord zu bilden und zu überprüfen
    Sebilist<String> majorChordTones = createChord(rootTone, "major");
    // Überprüfe, ob alle Töne des Dur-Akkords in der Eingabeliste vorhanden sind
    if (majorChordTones.length() == 3 &&
        toneList.contains(majorChordTones[0]) &&
        toneList.contains(majorChordTones[1]) &&
        toneList.contains(majorChordTones[2])) {
      // Füge den Akkordnamen hinzu. Sebilist sollte Duplikate hier selbst handhaben.
      foundChords.add("$rootTone" + "major");
    }

    // Versuche, einen Moll-Akkord zu bilden und zu überprüfen
    Sebilist<String> minorChordTones = createChord(rootTone, "minor");
    // Überprüfe, ob alle Töne des Moll-Akkords in der Eingabeliste vorhanden sind
    if (minorChordTones.length() == 3 &&
        toneList.contains(minorChordTones[0]) &&
        toneList.contains(minorChordTones[1]) &&
        toneList.contains(minorChordTones[2])) {
      // Füge den Akkordnamen hinzu. Sebilist sollte Duplikate hier selbst handhaben.
      foundChords.add("$rootTone" + "minor");
    }
  }

  return foundChords;
}

void transpose(Sebilist<String> liste, int steps, String plusOrMinus) {
  Sebilist<String> cromanticScale = createChromaticScale();
  Sebilist<int> newIndexes = new Sebilist();
  for (int i = 0; i < liste.length(); i++) {
    int startIndex = cromanticScale.SearchIndex(liste[i]);
    int newIndex;
    if (plusOrMinus == "+") {
      newIndex = (startIndex + steps) % 12;
    } else {
      newIndex = (startIndex - steps) % 12;
      if (newIndex < 0) {
        newIndex += 12;
      }
    }
    newIndexes.add(newIndex);
  }

  print("\n--- Transposed Tones ---");
  for (int i = 0; i < liste.length(); i++) {
    print("${liste[i]} --> ${cromanticScale[newIndexes[i]]}");
  }
  print("------------------------\n");
}

void chooseProgramm() {
  int? chosenIndex;
  bool check;
  do {
    check = false;
    print("\n--- Music Program ---");
    print("Welcome! Please choose one of the programs:");
    print("0 --> Create Chord");
    print("1 --> Create Scale");
    print("2 --> Calculate Interval");
    print("3 --> Find Key");
    print("4 --> Transpose");
    print("5 --> find chords");
    print("Type anything other than 0, 1, 2, 3, 4, 5 to exit the program.");
    print("---------------------\n");

    String? userInput = stdin.readLineSync();
    chosenIndex = null;

    if (userInput != null && checkUserInputIsNumber(userInput)) {
      int parsedInput = int.parse(userInput);

      if (parsedInput >= 0 && parsedInput < programmnames.length) {
        chosenIndex = parsedInput;
        startProgramm(programmnames[chosenIndex]);
        print(
          "\n"
          "Want to start another program? Press 'y'",
        );
        String startOtherProgramm = stdin.readLineSync() ?? "";
        startOtherProgramm = startOtherProgramm.toLowerCase();

        if (startOtherProgramm == "y") {
          check = true;
        }
      } else {
        print("Invalid input or program terminated.");
      }
    } else {
      print("Invalid input or program terminated.");
    }
  } while (chosenIndex != null && check == true);
}

bool checkUserInputIsNumber(String? UserInput) {
  if (num.tryParse(UserInput!) != null) {
    return true;
  }
  return false;
}

Sebilist<String> createChromaticScale() {
  List<String> grundTone = ["c", "d", "e", "f", "g", "a", "b"];
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

  if (cromaticScale.contains(tone) && Mod == "minor" ||
      cromaticScale.contains(tone) && Mod == "major") {
    final int index = cromaticScale.SearchIndex(tone);
    final int bterz = 4;
    final int lterz = 3;
    final int lastTone = 7;

    Chord.add(cromaticScale[index]);

    if (Mod == "minor") {
      Chord.add(cromaticScale[(index + lterz) % 12]);
      Chord.add(cromaticScale[(index + lastTone) % 12]);
    } else if (Mod == "major") {
      Chord.add(cromaticScale[(index + bterz) % 12]);
      Chord.add(cromaticScale[(index + lastTone) % 12]);
    }
  } else {
    print("Wrong input, please try again.");
    startProgramm(programmnames[0]);
  }

  return Chord;
}

dynamic calculateIntervalFromTwoTones(String toneOne, String toneTwo) {
  Sebilist<String> cromaticScale = createChromaticScale();
  int result = 0;
  if (cromaticScale.contains(toneOne) && cromaticScale.contains(toneTwo)) {
    int indexFromChordOne = cromaticScale.SearchIndex(toneOne);
    int indexFromChordTwo = cromaticScale.SearchIndex(toneTwo);
    int diff = (indexFromChordOne - indexFromChordTwo).abs();
    result = min(diff, 12 - diff);
  } else {
    print("Wrong input, please try again.");
    startProgramm(programmnames[2]);
  }

  return result;
}

Sebilist<String> createScale(String tone, String mod) {
  Sebilist<String> Scale = new Sebilist();
  Sebilist<String> cromaticScale = createChromaticScale();
  List<int> majorSteps = [2, 4, 5, 7, 9, 11];
  List<int> minorSteps = [2, 3, 5, 7, 8, 10];

  Scale.add(tone);
  if (cromaticScale.contains(tone) && mod == "major" ||
      cromaticScale.contains(tone) && mod == "minor") {
    int index = cromaticScale.SearchIndex(tone);
    if (mod == "major") {
      for (int step in majorSteps) {
        Scale.add(cromaticScale[(index + step) % 12]);
      }
    } else if (mod == "minor") {
      for (int step in minorSteps) {
        Scale.add(cromaticScale[(index + step) % 12]);
      }
    }
  } else {
    print("Wrong input, program will be restarted.");
    startProgramm(programmnames[1]);
  }

  return Scale;
}

void startProgramm(String Programmname) {
  Sebilist<String> UserInputs = createUserInputForProgramms(Programmname);
  int index = programmnames.indexOf(Programmname);

  if (Programmname == programmnames[0] ||
      Programmname == programmnames[1] ||
      Programmname == programmnames[2]) {
    if (UserInputs.length() < 2) {
      print("Invalid input for program '$Programmname'. Please try again.");
      startProgramm(programmnames[index]);
    } else {
      String inputOne = UserInputs[0];
      String inputTwo = UserInputs[1];

      bool isValid = false;
      if ((Programmname == programmnames[0] ||
              Programmname == programmnames[1]) &&
          isValidTone(inputOne) &&
          isValidMode(inputTwo)) {
        isValid = true;
      } else if (Programmname == programmnames[2] &&
          isValidTone(inputOne) &&
          isValidTone(inputTwo)) {
        isValid = true;
      }

      if (isValid) {
        (functions[index](inputOne, inputTwo));
        if (index == 0) {
          print(
            "the tones from " +
                inputOne +
                inputTwo +
                " are: " +
                (functions[index](inputOne, inputTwo)).toString(),
          );
        } else if (index == 1) {
          Sebilist<String> scale = new Sebilist();
          scale = functions[index](inputOne, inputTwo);
          print("the tones from the " + inputOne + inputTwo + " scale are: ");
          for (int i = 0; i < scale.length(); i++) {
            if (inputTwo == "major") {
              if (i == 0 || i == 3 || i == 4 && i != 6) {
                print(scale[i] + " --> represents " + scale[i] + "major chord");
              }
              if (i == 6) {
                print(
                  scale[i] + " --> represents " + scale[i] + "minor7b5 chord",
                );
              } else {
                print(scale[i] + " --> represents " + scale[i] + "minor chord");
              }
            }
            if (inputTwo == "minor") {
              if (i == 0 || i == 3 || i == 4) {
                print(scale[i] + " --> represents " + scale[i] + "minor chord");
              } else if (i == 1) {
                print(
                  scale[i] + " --> represents " + scale[i] + "minor7b5 chord",
                );
              } else {
                print(scale[i] + " --> represents " + scale[i] + "major chord");
              }
            }
          }
        } else if (index == 2) {
          print(
            "between " +
                inputOne +
                " and " +
                inputTwo +
                " are " +
                (functions[index](inputOne, inputTwo)).toString() +
                " halfsteps ",
          );
        }
      } else {
        print("Invalid input for program '$Programmname'. Please try again.");
        startProgramm(programmnames[index]);
      }
    }
  } else if (Programmname == programmnames[3]) {
    bool check = true;
    for (int i = 0; i < UserInputs.length(); i++) {
      if (!isValidTone(
            UserInputs[i].replaceAll("major", "").replaceAll("minor", ""),
          ) ||
          UserInputs[i].isEmpty) {
        check = false;
        break;
      }
    }

    if (check && checkUserInputAfterChordInput(UserInputs)) {
      // Direct call to findkey and print its output
      findkey(UserInputs);
    } else {
      print("Invalid input for program '$Programmname'. Please try again.");
      startProgramm(programmnames[index]);
    }
  } else if (Programmname == programmnames[4]) {
    if (UserInputs.length() < 3) {
      print(
        "Incorrect input for transpose. Please provide tones, steps, and direction.",
      );
      startProgramm(programmnames[index]);
    } else {
      String tonesInput = UserInputs[0];
      String stepsInput = UserInputs[1];
      String directionInput = UserInputs[2];

      Sebilist<String> tonesToTranspose = new Sebilist();
      List<String> rawTones = tonesInput.split(',');
      bool allTonesValid = true;
      for (var tone in rawTones) {
        String trimmedTone = tone.trim().toLowerCase();
        if (trimmedTone.isNotEmpty && isValidTone(trimmedTone)) {
          tonesToTranspose.add(trimmedTone);
        } else if (trimmedTone.isNotEmpty) {
          print(
            "Incorrect tone '$trimmedTone' for transpose. Please try again.",
          );
          allTonesValid = false;
          break;
        }
      }

      if (!allTonesValid || tonesToTranspose.length() == 0) {
        print(
          "Invalid input for tones. Please ensure valid tones are entered.",
        );
        startProgramm(programmnames[index]);
      } else {
        int? steps = int.tryParse(stepsInput);
        if (steps == null || steps < 0) {
          print("Invalid input for steps. Please enter a positive number.");
          startProgramm(programmnames[index]);
        } else {
          if (directionInput != "+" && directionInput != "-") {
            print(
              "Invalid input for direction. Please enter '+' or '-' instead of '$directionInput'.",
            );
            startProgramm(programmnames[index]);
          } else {
            transpose(tonesToTranspose, steps, directionInput);
          }
        }
      }
    }
  } else if (Programmname == programmnames[5]) {
    if (UserInputs.length() < 3) {
      print("To find chords, please enter at least 3 tones.");
      startProgramm(
        programmnames[index],
      ); // Startet das Programm neu, wenn zu wenige Töne
    } else {
      Sebilist<String> foundChords = functions[index](UserInputs);
      if (foundChords.length() > 0) {
        print(
          "From the tones ${UserInputs.toString()}, the following major or minor chords were found:",
        );
        for (int i = 0; i < foundChords.length(); i++) {
          print("- ${foundChords[i]}");
        }
      } else {
        print(
          "No major or minor chords could be formed from the tones ${UserInputs.toString()}.",
        );
      }
    }
  }
}

String getUserInput() {
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print("Wrong Input, please type again.");
    return getUserInput();
  } else {
    return input.trim().toLowerCase();
  }
}

Sebilist<String> createUserInputForProgramms(String Programmname) {
  Sebilist<String> cromaticScale = createChromaticScale();
  Sebilist<String> UserInputs = new Sebilist();

  if (Programmname == programmnames[0] || Programmname == programmnames[1]) {
    print(
      "Please enter your desired base tone. \n"
      " (${cromaticScale})",
    );

    String chord = getUserInput();
    print("Please enter your desired mode. (major/minor)");
    String mode = getUserInput();

    UserInputs.add(chord);
    UserInputs.add(mode);
  } else if (Programmname == programmnames[2]) {
    print(
      "Please enter your first desired tone. \n"
      "${cromaticScale})",
    );

    String firstTone = getUserInput();
    print(
      "Please enter your 2nd desired tone. \n"
      "${cromaticScale})",
    );
    String secondTone = getUserInput();

    UserInputs.add(firstTone);
    UserInputs.add(secondTone);
  } else if (Programmname == programmnames[3]) {
    print(
      "Please enter your chords in a row, separated by a comma. \n" +
          "Possible chords are: ${cromaticScale} major/minor",
    );

    String? rawInput = getUserInput();
    if (rawInput.isNotEmpty) {
      List<String> chords = rawInput
          .split(',')
          .map((s) => s.trim().toLowerCase())
          .toList();
      for (var chord in chords) {
        UserInputs.add(chord);
      }
    }
  } else if (Programmname == programmnames[4]) {
    Sebilist<String> cromaticScale = createChromaticScale();
    print(
      "Please enter the tones you want to transpose, separated by commas $cromaticScale",
    );
    String tonesInput = getUserInput();
    print("Please enter the number of half steps to transpose (only Integer).");
    String stepsInput = getUserInput();
    print("Please enter the direction ('+' for up, '-' for down).");
    String directionInput = getUserInput();

    if (tonesInput.isNotEmpty &&
        stepsInput.isNotEmpty &&
        directionInput.isNotEmpty) {
      UserInputs.add(tonesInput);
      UserInputs.add(stepsInput);
      UserInputs.add(directionInput);
    }
  } else if (Programmname == programmnames[5]) {
    print(
      "Please enter the tones you have, separated by commas. Example: c, e, g \n"
      "Possible tones are: $cromaticScale",
    );
    String? rawInput = getUserInput();

    if (rawInput.isNotEmpty) {
      List<String> tones = rawInput
          .split(',')
          .map((s) => s.trim().toLowerCase())
          .toList();

      for (var tone in tones) {
        if (isValidTone(tone)) {
          UserInputs.add(tone);
        } else {
          print(
            "Invalid tone '$tone' detected. Please enter valid tones from the chromatic scale.",
          );

          return createUserInputForProgramms(Programmname);
        }
      }
    } else {
      print("No tones entered. Please try again.");

      return createUserInputForProgramms(Programmname);
    }
  }

  return UserInputs;
}

bool checkUserInputAfterChordInput(Sebilist<String> liste) {
  Sebilist<String> cromanticScale = createChromaticScale();
  Sebilist<String> chordlist = new Sebilist();

  bool checker = true;
  for (int i = 0; i < cromanticScale.length(); i++) {
    chordlist.add(cromanticScale[i] + "major");
    chordlist.add(cromanticScale[i] + "minor");
  }

  for (int i = 0; i < liste.length(); i++) {
    if (!chordlist.contains(liste[i])) {
      checker = false;
    }
  }

  return checker;
}

bool isValidTone(String tone) {
  return createChromaticScale().contains(tone.toLowerCase());
}

bool isValidMode(String mode) {
  mode = mode.toLowerCase();
  return mode == "major" || mode == "minor";
}

Sebilist<String> getDiatonicChordsForScale(String tone, String mode) {
  Sebilist<String> diatonicChords = new Sebilist();
  Sebilist<String> scaleTones = createScale(tone, mode);

  List<String> majorChordQualities = [
    "major",
    "minor",
    "minor",
    "major",
    "major",
    "minor",
    "diminished",
  ];
  List<String> minorChordQualities = [
    "minor",
    "diminished",
    "major",
    "minor",
    "minor",
    "major",
    "major",
  ];

  List<String> qualities = (mode == "major")
      ? majorChordQualities
      : minorChordQualities;

  for (int i = 0; i < scaleTones.length(); i++) {
    diatonicChords.add(scaleTones[i] + qualities[i]);
  }

  return diatonicChords;
}

void findkey(Sebilist<String> chordlist) {
  String detectedKey = "";

  Sebilist<String> allChordTones = getChordTonesFromUserInputList(chordlist);
  List<String> sortedChordList = getSortedListFromChords(chordlist);
  List<int> listOfCounter = [];

  for (int i = 0; i < chordlist.length(); i++) {
    Sebilist<String> currentScale = createScale(
      sortedChordList[i * 2],
      sortedChordList[i * 2 + 1],
    );

    int counter = 0;
    for (int j = 0; j < allChordTones.length(); j++) {
      if (currentScale.contains(allChordTones[j])) {
        counter++;
      }
    }
    listOfCounter.add(counter);
  }

  detectedKey = chordlist[listOfCounter.indexOf(getMaxValue(listOfCounter))];

  String keyTone = cutChordFromChordTotal(detectedKey, "m");
  String keyMode = cutModFromChordTotal(detectedKey, "m");
  Sebilist<String> detectedKeyScale = createScale(keyTone, keyMode);
  Sebilist<String> diatonicChordsInKey = getDiatonicChordsForScale(
    keyTone,
    keyMode,
  );

  Sebilist<String> outOfKeyTones = new Sebilist();
  for (int i = 0; i < allChordTones.length(); i++) {
    if (!detectedKeyScale.contains(allChordTones[i])) {
      outOfKeyTones.add(allChordTones[i]);
    }
  }

  Sebilist<String> outOfKeyChords = new Sebilist();
  for (int i = 0; i < chordlist.length(); i++) {
    if (!diatonicChordsInKey.contains(chordlist[i])) {
      outOfKeyChords.add(chordlist[i]);
    }
  }

  print("\n--- Key Analysis ---");
  print("The detected key is: $detectedKey");
  if (outOfKeyTones.length() > 0) {
    print(
      "The following tones from your chords are not in the $detectedKey scale: ${outOfKeyTones.toString()}",
    );
  } else {
    print("All tones from your chords are within the $detectedKey scale.");
  }

  if (outOfKeyChords.length() > 0) {
    print(
      "The following chords from your input are not in the $detectedKey Scale: ${outOfKeyChords.toString()}",
    );
  } else {
    print("All input chords are in the $detectedKey key scale.");
  }
  print("--------------------\n");
}

int getMaxValue(List<int> resultList) {
  if (resultList.isEmpty) {
    return 0;
  }
  return resultList.reduce((currentMax, element) => max(currentMax, element));
}

List<String> getSortedListFromChords(Sebilist<String> chordlist) {
  List<String> cutedChords = [];

  for (int i = 0; i < chordlist.length(); i++) {
    String subStringChord = cutChordFromChordTotal(chordlist[i], "m");
    String subStringMod = cutModFromChordTotal(chordlist[i], "m");
    cutedChords.add(subStringChord);
    cutedChords.add(subStringMod);
  }

  return cutedChords;
}

String cutChordFromChordTotal(String element, String char) {
  int index = element.indexOf(char);
  String subStringOne = "";

  for (int i = 0; i < element.length; i++) {
    if (i < index) {
      subStringOne += element[i];
    }
  }

  return subStringOne;
}

String cutModFromChordTotal(String element, String char) {
  int index = element.indexOf(char);
  String subString = "";

  for (int i = 0; i < element.length; i++) {
    if (i >= index) {
      subString += element[i];
    }
  }

  return subString;
}

Sebilist<String> getChordTonesFromUserInputList(Sebilist<String> list) {
  Sebilist<String> chordTonesTotal = new Sebilist();
  List<String> chordTonesListed = getSortedListFromChords(list);

  for (int i = 0; i < list.length(); i++) {
    Sebilist<String> currentChord = createChord(
      chordTonesListed[i * 2],
      chordTonesListed[(i * 2 + 1)],
    );
    for (int j = 0; j < currentChord.length(); j++) {
      chordTonesTotal.add(currentChord[j]);
    }
  }
  return chordTonesTotal;
}
