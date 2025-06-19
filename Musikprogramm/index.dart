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
  chooseProgramm();
}

void chooseProgramm() {
  int? chosenIndex; // Use a nullable int to manage the state

  do {
    print("\n--- Music Program ---");
    print("Welcome! Please choose one of the programs:");
    print("0 --> Create Chord");
    print("1 --> Create Scale");
    print("2 --> Calculate Interval");
    print("Type anything other than 0, 1, or 2 to exit the program.");
    print("---------------------\n");

    String? userInput = stdin.readLineSync(); // Read user input
    chosenIndex = null; // Reset the index before each iteration

    if (userInput != null && checkUserInputIsNumber(userInput)) {
      int parsedInput = int.parse(userInput);

      // Check if the parsed index is within the valid range
      if (parsedInput >= 0 && parsedInput < programmnames.length) {
        chosenIndex = parsedInput; // A valid index was chosen
        // Start the program using the name of the chosen program
        startProgramm(
          programmnames[chosenIndex],
        ); // chosenIndex is now guaranteed not to be null
      } else {
        print("Invalid input or program terminated.");
      }
    } else {
      // If the input is null, empty, or not a number
      print("Invalid input or program terminated.");
    }
  } while (chosenIndex !=
      null); // The loop continues as long as a valid program was chosen
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
  print(Chord);

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
  print(result);
}

void createScale(String tone, String mod) {
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
  print(Scale);
}

void startProgramm(String Programmname) {
  Sebilist<dynamic> UserInputs = createUserInputForProgramms(Programmname);
  int index = programmnames.indexOf(Programmname);
  if (Programmname == programmnames[0] ||
      Programmname == programmnames[1] ||
      Programmname == programmnames[2]) {
    if (checkUserInputDatatype(UserInputs[0]) == "string" &&
        checkUserInputDatatype(UserInputs[1]) == "string") {
      functions[index](UserInputs[0], UserInputs[1]);
    } else {
      print("wrong Userinput pls again");
      startProgramm(programmnames[index]);
    }
  }
}

String? CreateUserInput() {
  String? Input = stdin.readLineSync();

  if (Input != null && !Input.isEmpty)
    return Input.toLowerCase();
  else {
    print("wrong Input pls put in again");
    return CreateUserInput();
  }
}

Sebilist<dynamic> createUserInputForProgramms(String Programmname) {
  Sebilist<String> cromaticScale = createChromaticScale();
  Sebilist<dynamic> UserInputs = new Sebilist();

  if (Programmname == programmnames[0] || Programmname == programmnames[1]) {
    print(
      "pls write your baseTone that you wish. \n"
      " ${cromaticScale})",
    );

    dynamic chord = CreateUserInput();
    print("pls write your mode that you wish. (major/minor) \n");
    dynamic mode = CreateUserInput();

    UserInputs.add(chord);
    UserInputs.add(mode);
  } else if (Programmname == programmnames[2]) {
    print(
      "pls write your first tone that you wish. \n"
      "${cromaticScale})",
    );

    dynamic firstTone = CreateUserInput();
    print(
      "pls write your 2nd tone that you \n"
      "${cromaticScale})",
    );
    dynamic secondTone = CreateUserInput();

    UserInputs.add(firstTone);
    UserInputs.add(secondTone);
  }
  return UserInputs;
}

void findkey (Sebilist<String>chordList) {


}