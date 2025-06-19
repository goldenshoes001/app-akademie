void printnumber(int zahl) {
  print(zahl);
}

void triplePrint(String text) {
  for (int i = 0; i < 3; i++) {
    print(text);
  }
}

void main() {
  printnumber(1);
  printnumber(2);
  printnumber(3);

  triplePrint("text");
}
