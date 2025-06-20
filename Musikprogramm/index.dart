import 'SebiList.dart';
import "dart:math";
import 'dart:io';

List<String> programmnames = ["chord", "scale", "intervall"];
List<Function> functions = [
  createChord,
  createScale,
  calculateIntervalFromTwoTones,
];

//import 'dart:io';

void main() {
  Sebilist<String> chords = new Sebilist();
  chords.add("dmajor"); //ceg c2 e1 g2 f1 a1 h1 d1
  chords.add("gmajor");
  chords.add("cmajor");
  chords.add("fmajor");

  print(findkey(chords));
}

void chooseProgramm() {
  int? chosenIndex; // Use a nullable int to manage the state
  bool check;
  do {
    check = false;
    print("\n--- Music Program ---");
    print("Welcome! Please choose one of the programs:");
    print("0 --> Create Chord");
    print("1 --> Create Scale");
    print("2 --> Calculate Interval");
    print("Type anything other than 0, 1, or 2 to exit the program.");
    print("---------------------\n");

    String? userInput = stdin.readLineSync(); // Read user input
    chosenIndex = null; // Reset the index before each iteration
    ;

    if (userInput != null && checkUserInputIsNumber(userInput)) {
      int parsedInput = int.parse(userInput);

      // Check if the parsed index is within the valid range
      if (parsedInput >= 0 && parsedInput < programmnames.length) {
        chosenIndex = parsedInput; // A valid index was chosen
        // Start the program using the name of the chosen program
        startProgramm(programmnames[chosenIndex]);
        print(
          "\n"
          "wanna start a other Program? than press y",
        );
        String startOtherProgramm = stdin.readLineSync() ?? "";
        startOtherProgramm = startOtherProgramm.toLowerCase();

        if (startOtherProgramm == "y") {
          check = true;
        }
        // chosenIndex is now guaranteed not to be null
      } else {
        print("Invalid input or program terminated.");
      }
    } else {
      // If the input is null, empty, or not a number
      print("Invalid input or program terminated.");
    }
  } while (chosenIndex != null &&
      check ==
          true); // The loop continues as long as a valid program was chosen
  // and is not terminated by invalid
}
//UserInputControllFunctions

// Buts out the Datatype from a UserInput (Bool,Number,String,Null)
String checkUserInputDatatype(String? UserInput) {
  String checker;

  if (!checkUserInputisNull(UserInput) && !checkUserInputisEmpty(UserInput)) {
    if (checkUserInputIsNumber(UserInput)) {
      checker = "number";
    } else if (chekcUserInputisBool(UserInput)) {
      checker = "bool";
    } else
      checker = "string";
  } else {
    checker = "null";
  }

  return checker;
}

// checks if UserInput is a Number
bool checkUserInputIsNumber(String? UserInput) {
  if (num.tryParse(UserInput!) != null) {
    return true;
  }
  return false;
}

// checks if UserInput is empty
bool checkUserInputisEmpty(String? UserInput) {
  if (UserInput!.isEmpty) {
    return true;
  }
  return false;
}

//checks if the Userinput is null
bool checkUserInputisNull(String? UserInput) {
  if (UserInput == null) {
    return true;
  } else
    return false;
}

// checks if the Userinput is bool
bool chekcUserInputisBool(String? UserInput) {
  if (bool.tryParse(UserInput!) != null) {
    return true;
  } else {
    return false;
  }
}

//MusicProgrammFunctions
//Converts Userinput that all chars are lowercase
String? convertUserInputToLowercase(String? UserInput) {
  return UserInput!.toLowerCase();
}

//Creates cromaticScale and returns it as a List without duplicates
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

//Creates Chord. The User has to say if he wants "Minor or Major and which chord he wants
//and the Programm creates the chord, saves it in a list and returns the list.
//The list cant has duplicates.
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
    print("wrong Input try again");
    startProgramm(programmnames[0]);
  }
  /*
  print(
    "\n"
    "\n"
    "\n"
    "\n"
    "the Tones from a $tone  $Mod chord are: $Chord",
  );
*/
  return Chord;
}

//calculates the Intervals from Two Tones with the absoulte Value
//if one onf the given Tones arent in cromaticScale puts out -1
void calculateIntervalFromTwoTones(String toneOne, String toneTwo) {
  Sebilist<String> cromaticScale = createChromaticScale();
  int result = 0;
  if (cromaticScale.contains(toneOne) && cromaticScale.contains(toneTwo)) {
    int indexFromChordOne = cromaticScale.SearchIndex(toneOne);
    int indexFromChordTwo = cromaticScale.SearchIndex(toneTwo);
    int diff = (indexFromChordOne - indexFromChordTwo).abs();
    result = min(diff, 12 - diff);
  } else {
    print("wrong Input pls again");
    startProgramm(programmnames[2]);
  }
  print(
    "\n"
    "\n"
    "\n"
    "\n"
    "the count of halfsteps between $toneOne and $toneTwo is: $result",
  );
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
    print("wrong input programm will be restarted");
    startProgramm(programmnames[1]);
  }
  //print(
  //"\n"
  //"\n"
  //"\n"
  //"\n"
  //"$tone $mod scale: $Scale",
  //);

  return Scale;
}

void startProgramm(String Programmname) {
  Sebilist<String> UserInputs = createUserInputForProgramms(Programmname);

  int index = programmnames.indexOf(Programmname);

  if (UserInputs.length() < 2) {
    print("Invalid input for program '$Programmname'. Please try again.");
    startProgramm(programmnames[index]);
  }
  if (UserInputs.length() >= 2) {
    String inputOne = UserInputs[0];
    String inputTwo = UserInputs[1];

    bool isvalid = false;
    if (Programmname == programmnames[0] || Programmname == programmnames[1]) {
      if (isValidTone(UserInputs[0]) && isValidMode(UserInputs[1])) {
        isvalid = true;
      }
    } else if (Programmname == programmnames[2]) {
      if (isValidTone(UserInputs[0]) && isValidTone(UserInputs[1])) {
        isvalid = true;
      }
    }

    if (isvalid) {
      functions[index](inputOne, inputTwo);
    } else {
      print("Invalid input for program '$Programmname'. Please try again.");
      startProgramm(programmnames[index]);
    }
  }
}

String? getUserInput() {
  String Input = stdin.readLineSync() ?? "";
  Sebilist<String> currentValue = new Sebilist();

  Input = Input.trim();
  currentValue.add(Input);

  if (!Input.isEmpty)
    return Input.toLowerCase();
  else {
    print("wrong Input pls put in again");
    return getUserInput();
  }
}

Sebilist<String> createUserInputForProgramms(String Programmname) {
  Sebilist<String> cromaticScale = createChromaticScale();
  Sebilist<String> UserInputs = new Sebilist();

  if (Programmname == programmnames[0] || Programmname == programmnames[1]) {
    print(
      "pls write your baseTone that you wish. \n"
      " ${cromaticScale})",
    );

    String chord = getUserInput()!;
    print("pls write your mode that you wish. (major/minor)");
    String mode = getUserInput()!;

    UserInputs.add(chord);
    UserInputs.add(mode);
  } else if (Programmname == programmnames[2]) {
    print(
      "pls write your first tone that you wish. \n"
      "${cromaticScale})",
    );

    String firstTone = getUserInput()!;
    print(
      "pls write your 2nd tone that you \n"
      "${cromaticScale})",
    );
    String secondTone = getUserInput()!;

    UserInputs.add(firstTone);
    UserInputs.add(secondTone);
  }
  return UserInputs;
}

bool checkUserInputAfterMinorAndMajor(Sebilist<String> liste) {
  bool checker = true;
  for (int i = 0; i < liste.length(); i++) {
    if (liste[i] != "major" && liste[i] != "minor") {
      checker = false;
    }
  }
  return checker;
}

bool checkerUserInputAfterCromanticScale(Sebilist<String> liste) {
  Sebilist<String> cromaticScale = createChromaticScale();

  bool checker = true;
  for (int i = 0; i < liste.length(); i++) {
    if (!cromaticScale.contains(liste[i])) {
      checker = false;
    }

    print(checker);
  }
  return checker;
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

String findkey(Sebilist<String> chordlist) {
  String key = "";

  Sebilist<String> allChordTones = getChordTonesFromUserInputList(chordlist);
  List<String> sortedChordList = getSortedListFromChords(chordlist);
  List<int> listOfCounter = [];

  for (int i = 0; i < chordlist.length(); i++) {
    Sebilist<String> currentScale = createScale(
      sortedChordList[i * 2],
      sortedChordList[i * 2 + 1],
    );

    int counter = 0;
    for (int i = 0; i < allChordTones.length(); i++) {
      if (currentScale.contains(allChordTones[i])) {
        counter++;
      }
    }

    listOfCounter.add(counter);
  }

  key = chordlist[listOfCounter.indexOf(getMaxValue(listOfCounter))];
  return key;
}

int getMaxValue(List<int> resultList) {
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
