import 'SebiList.dart';
import "dart:math";
import 'dart:io';

List<String> programmnames = [
  "create chord tones",
  "create scales",
  "calcutlate intervall from 2 tones",
  "find the key the most chords are maching",
  "transpose a list of notes transpose",
  "find all chords that can be created from tones in a list",
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

/*
    erstellt die chromatische Tonleiter(c,c#,d,d#,e,f,f#,g,g#,a,b)
    erstellt dann von jedem Ton den Dur und Mollakkord, speichert
    die Töne der jeweiligen Akkorde dann in einer Liste (major/minor Chordtones)
    und kontrolliert dann, ob diese Töne in der übergebenen Liste sind

    --> ja speicher in foundChords
    --> nein dann nicht

    gibt dann alle gefundenen Akkorde zurück
*/
Sebilist<String> findChords(Sebilist<String> toneList) {
  Sebilist<String> foundChords = new Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  for (int i = 0; i < chromaticScale.length(); i++) {
    String rootTone = chromaticScale[i];

    Sebilist<String> majorChordTones = createChord(rootTone, "major");
    if (majorChordTones.length() == 3 &&
        toneList.contains(majorChordTones[0]) &&
        toneList.contains(majorChordTones[1]) &&
        toneList.contains(majorChordTones[2])) {
      foundChords.add("$rootTone" + "major");
    }

    Sebilist<String> minorChordTones = createChord(rootTone, "minor");
    if (minorChordTones.length() == 3 &&
        toneList.contains(minorChordTones[0]) &&
        toneList.contains(minorChordTones[1]) &&
        toneList.contains(minorChordTones[2])) {
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

/*
startet das Programm das der Benutzer starten möchte
choosenIndex ist der index des Programms
isValidProgramCHoice checkt ob der gewählte Index ein
gültiger Index ist
in continueProgramm wird gespeichert ob der Nutzer noch einen 
Durchlauf möchte
*/
void chooseProgramm() {
  bool continueProgram = true;

  while (continueProgram) {
    int? chosenIndex = getProgramChoice();

    if (isValidProgramChoice(chosenIndex)) {
      startProgramm(programmnames[chosenIndex!]);

      continueProgram = promptForAnotherRun();
    } else {
      print("Invalid input or program terminated.");
      continueProgram = false;
    }
  }
}

//Erstellt eine Nutzereingabe mit dem namen userInput
//und gibt diesen wenn er nicht null und wenn er eine Zahl ist als
//Integer zurüclk
int? getProgramChoice() {
  printPotencialProgramms(); // Zeigt das Menü an
  String? userInput = stdin.readLineSync();
  if (userInput != null && checkUserInputIsNumber(userInput)) {
    return int.parse(userInput);
  }
  return null; // Gibt null zurück, wenn die Eingabe ungültig ist
}
/*
Checkt ob die eingegebene Zahl:
- in der Range der Programme ist
- größer 0 ist
- kleiner als programmnames.length

---> wenn ja returnwert = true
---> wenn nein returnwert = false
*/
bool isValidProgramChoice(int? choice) {
  return choice != null && choice >= 0 && choice < programmnames.length;
}

//gibt ein boolean zurück, der aussagt ob ein Nutzer noch einen Durchgang möchte
bool promptForAnotherRun() {
  print("\nWant to start another program? Press 'y'");

  String startOtherProgramm = stdin.readLineSync() ?? "";
  return startOtherProgramm.toLowerCase() == "y";
}

//gibt alle potenziellen Programme aus
void printPotencialProgramms() {
  stdout.write("\x1b[Hm\x1b[2J");
  print("\n--- Music Program ---");
  print("Welcome! Please choose one of the programs:");

  for (int i = 0; i < programmnames.length; i++) {
    print("$i --> ${programmnames[i]}");
  }

  print("Type anything else to exit the program.");
  print("---------------------\n");
}
//prüft ob der Wert der eingegeben wurde eine Zahl ist
bool checkUserInputIsNumber(String? UserInput) {
  if (num.tryParse(UserInput!) != null) {
    return true;
  }
  return false;
}
//erstellt chromatische Tonleiter
// Rückgabewert ist die chromatische Liste 
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
//erstellt dur/moll akkord jenach dem ob mod major oder minor ist
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
    // Wenn die Eingabe für createChord ungültig ist, wird hier keine Rekursion mehr aufgerufen,
    // sondern eine leere Liste zurückgegeben. Die aufrufende Funktion muss dies behandeln.
    return Chord;
  }

  return Chord;
}
//berechnet Halbtonschritte zwischen 2 tönen und gibt die anzahl der Schritte dann als return zurück
int calculateIntervalFromTwoTones(String toneOne, String toneTwo) {
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
//erstellt Tonleiter von dem Ton (c,c#,d,d#,e,f,f#,g,g#,a,b) und dem Modus (Major,Minor) der übergeben wurde
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
//Erstellt eine Nutzereingabe und checkt ob diese null ist wenn nicht null 
//ist der Returnwert die Nutzereingabe
//wenn Nutzereingabe = null --> rekursiver Aufruf
String getUserInput() {
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print("Wrong Input, please type again.");
    return getUserInput();
  } else {
    return input.trim().toLowerCase();
  }
}

//ruft abhängig davon welches der Programm der Benutzer starten möchte (Programmname), das entsprechende Programm
void startProgramm(String Programmname) {
  int index = programmnames.indexOf(Programmname);

  // Use a switch statement for clearer program handling
  switch (Programmname) {
    case "create chord tones":
    case "create scales":
    case "calcutlate intervall from 2 tones":
      handleToneAndModePrograms(Programmname, index);
      break;
    case "find the key the most chords are maching":
      handleFindKeyProgram(Programmname, index);
      break;
    case "transpose a list of notes transpose":
      handleTransposeProgram(Programmname, index);
      break;
    case "find all chords that can be created from tones in a list":
      handleFindChordsProgram(Programmname, index);
      break;
    default:
      print("Unknown program: $Programmname");
  }
}

//startet/überprüft Progamme die eine note und einen Modus oder 2 Töne brauchen)
//wenn wert nicht richtig --> rekursiver Aufruf über startProgramm
void handleToneAndModePrograms(String programName, int index) {
  Sebilist<String> userInputs = getToneAndModeInputs(programName);

  if (userInputs.length() < 2) {
    print("Invalid input for program '$programName'. Please try again.");
    startProgramm(programmnames[index]);
    return;
  }

  String inputOne = userInputs[0];
  String inputTwo = userInputs[1];

  bool isValid = false;
  if ((programName == programmnames[0] || programName == programmnames[1]) &&
      isValidTone(inputOne) &&
      isValidMode(inputTwo)) {
    isValid = true;
  } else if (programName == programmnames[2] &&
      isValidTone(inputOne) &&
      isValidTone(inputTwo)) {
    isValid = true;
  }

  if (isValid) {
    executeToneAndModeProgram(programName, inputOne, inputTwo, index);
  } else {
    print("Invalid input for program '$programName'. Please try again.");
    startProgramm(programmnames[index]);
  }
}
//führt Progamme die eine note und einen Modus brauchen aus und gibt deren ergebnisse aus
void executeToneAndModeProgram(
  String programName,
  String inputOne,
  String inputTwo,
  int index,
) {
  dynamic result = functions[index](inputOne, inputTwo);

  if (index == 0) {
    print("The tones from $inputOne $inputTwo are: $result");
  } else if (index == 1) {
    Sebilist<String> scale = result as Sebilist<String>;
    print("The tones from the $inputOne $inputTwo scale are: ");
    printScaleAnalysis(scale, inputTwo);
  } else if (index == 2) {
    print("Between $inputOne and $inputTwo are $result half-steps.");
  }
}
//gibt die Tonleiter und deren entsprechenden Akkorde aus
void printScaleAnalysis(Sebilist<String> scale, String mode) {
  for (int i = 0; i < scale.length(); i++) {
    String tone = scale[i];
    String chordType = "";
    if (mode == "major") {
      if (i == 0 || i == 3 || i == 4) {
        chordType = "major";
      } else if (i == 6) {
        chordType = "minor7b5"; // Diminished triad (m7b5 for diatonic 7th)
      } else {
        chordType = "minor";
      }
    } else if (mode == "minor") {
      if (i == 0 || i == 3 || i == 4) {
        chordType = "minor";
      } else if (i == 1) {
        chordType = "minor7b5";
      } else {
        chordType = "major";
      }
    }
    print("$tone --> represents $tone $chordType chord");
  }
}

// New helper function for handling the "find the key" program
void handleFindKeyProgram(String programName, int index) {
  Sebilist<String> userInputs = getFindKeyInputs(programName);
  List<String> userInputsasList = [];

  for (int i = 0; i < userInputs.length(); i++) {
    userInputsasList.add(userInputs[i]);
  }
  bool allInputsValid = true;
  if (!checkUserInputAfterChordInput(userInputs)) {
    allInputsValid = false;
  }

  // Also check if individual chord inputs are valid tones (e.g., "cmajor" -> "c")
  for (var chordInput in userInputsasList) {
    String tonePart = chordInput
        .replaceAll("major", "")
        .replaceAll("minor", "");
    if (!isValidTone(tonePart) || tonePart.isEmpty) {
      allInputsValid = false;
      break;
    }
  }

  if (allInputsValid && userInputs.length() > 0) {
    functions[index](userInputs);
  } else {
    print("Invalid input for program '$programName'. Please try again.");
    startProgramm(programmnames[index]);
  }
}

// New helper function for handling the "transpose" program
void handleTransposeProgram(String programName, int index) {
  Sebilist<String> userInputs = getTransposeInputs(programName);

  if (userInputs.length() < 3) {
    print(
      "Incorrect input for transpose. Please provide tones, steps, and direction.",
    );
    startProgramm(programmnames[index]);
    return;
  }

  String tonesInput = userInputs[0];
  String stepsInput = userInputs[1];
  String directionInput = userInputs[2];

  Sebilist<String> tonesToTranspose = Sebilist();
  List<String> rawTones = tonesInput.split(',');
  bool allTonesValid = true;
  for (var tone in rawTones) {
    String trimmedTone = tone.trim().toLowerCase();
    if (trimmedTone.isNotEmpty && isValidTone(trimmedTone)) {
      tonesToTranspose.add(trimmedTone);
    } else if (trimmedTone.isNotEmpty) {
      print("Incorrect tone '$trimmedTone' for transpose. Please try again.");
      allTonesValid = false;
      break;
    }
  }

  if (!allTonesValid || tonesToTranspose.length() == 0) {
    print("Invalid input for tones. Please ensure valid tones are entered.");
    startProgramm(programmnames[index]);
    return;
  }

  int? steps = int.tryParse(stepsInput);
  if (steps == null || steps < 0) {
    print("Invalid input for steps. Please enter a positive number.");
    startProgramm(programmnames[index]);
    return;
  }

  if (directionInput != "+" && directionInput != "-") {
    print(
      "Invalid input for direction. Please enter '+' or '-' instead of '$directionInput'.",
    );
    startProgramm(programmnames[index]);
    return;
  }

  transpose(tonesToTranspose, steps, directionInput);
}

// New helper function for handling the "find chords" program
void handleFindChordsProgram(String programName, int index) {
  Sebilist<String> userInputs = getChordsInputs(programName);

  if (userInputs.length() < 3) {
    print("To find chords, please enter at least 3 tones.");
    startProgramm(programmnames[index]);
    return;
  }

  Sebilist<String> foundChords = functions[index](userInputs);
  if (foundChords.length() > 0) {
    print(
      "From the tones ${userInputs.toString()}, the following major or minor chords were found:",
    );
    for (int i = 0; i < foundChords.length(); i++) {
      print("- ${foundChords[i]}");
    }
  } else {
    print(
      "No major or minor chords could be formed from the tones ${userInputs.toString()}.",
    );
  }
}

// Refactored createUserInputForProgramms
Sebilist<String> createUserInputForProgramms(String Programmname) {
  switch (Programmname) {
    case "create chord tones":
    case "create scales":
      return getToneAndModeInputs(Programmname);
    case "calcutlate intervall from 2 tones":
      return getTwoToneInputs(Programmname);
    case "find the key the most chords are maching":
      return getFindKeyInputs(Programmname);
    case "transpose a list of notes transpose":
      return getTransposeInputs(Programmname);
    case "find all chords that can be created from tones in a list":
      return getChordsInputs(Programmname);
    default:
      return Sebilist<String>(); // Should not happen with current logic
  }
}

// New helper function to get tone and mode inputs
Sebilist<String> getToneAndModeInputs(String programName) {
  Sebilist<String> userInputs = Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  print(
    "Please enter your desired base tone. \n"
    "Possible tones: $chromaticScale",
  );
  String tone = getUserInput();

  print("Please enter your desired mode. (major/minor)");
  String mode = getUserInput();

  userInputs.add(tone);
  userInputs.add(mode);
  return userInputs;
}

// New helper function to get two tone inputs
Sebilist<String> getTwoToneInputs(String programName) {
  Sebilist<String> userInputs = Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  print(
    "Please enter your first desired tone. \n"
    "Possible tones: $chromaticScale",
  );
  String firstTone = getUserInput();

  print(
    "Please enter your 2nd desired tone. \n"
    "Possible tones: $chromaticScale",
  );
  String secondTone = getUserInput();

  userInputs.add(firstTone);
  userInputs.add(secondTone);
  return userInputs;
}

// New helper function to get find key inputs (chords)
Sebilist<String> getFindKeyInputs(String programName) {
  Sebilist<String> userInputs = Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();
  List<String> chromaticScaleasList = [];

  for (int i = 0; i < chromaticScale.length(); i++) {
    chromaticScaleasList.add(chromaticScale[i]);
  }
  print(
    "Please enter your chords in a row, separated by a comma. \n"
    "Possible chords are: ${chromaticScaleasList} Major/Minor",
  );

  String rawInput = getUserInput();
  if (rawInput.isNotEmpty) {
    List<String> chords = rawInput
        .split(',')
        .map((s) => s.trim().toLowerCase())
        .toList();
    for (var chord in chords) {
      userInputs.add(chord);
    }
  }
  return userInputs;
}

// New helper function to get transpose inputs
Sebilist<String> getTransposeInputs(String programName) {
  Sebilist<String> userInputs = Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  print(
    "Please enter the tones you want to transpose, separated by commas.\n"
    "Possible tones: $chromaticScale",
  );
  String tonesInput = getUserInput();

  print("Please enter the number of half steps to transpose (only Integer).");
  String stepsInput = getUserInput();

  print("Please enter the direction ('+' for up, '-' for down).");
  String directionInput = getUserInput();

  if (tonesInput.isNotEmpty &&
      stepsInput.isNotEmpty &&
      directionInput.isNotEmpty) {
    userInputs.add(tonesInput);
    userInputs.add(stepsInput);
    userInputs.add(directionInput);
  }
  return userInputs;
}

Sebilist<String> getChordsInputs(String programName) {
  Sebilist<String> userInputs = Sebilist();
  Sebilist<String> chromaticScale = createChromaticScale();

  print(
    "Please enter the tones you have, separated by commas. Example: \n"
    "Possible tones are: $chromaticScale",
  );
  String rawInput = getUserInput();

  if (rawInput.isNotEmpty) {
    List<String> tones = rawInput
        .split(',')
        .map((s) => s.trim().toLowerCase())
        .toList();

    for (var tone in tones) {
      if (isValidTone(tone)) {
        userInputs.add(tone);
      } else {
        print(
          "Invalid tone '$tone' detected. Please enter valid tones from the chromatic scale.",
        );
        // Recursively call to re-prompt for input if invalid tone is found
        return getChordsInputs(programName);
      }
    }
  } else {
    print("No tones entered. Please try again.");
    return getChordsInputs(programName);
  }
  return userInputs;
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
