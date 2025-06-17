void main() {
  int startZahl = 1;
  int endZahl = 101;
  int kleineZahl = 10;
  int mittlereZahl = 60;

  for (int i = startZahl; i < endZahl; i++) {
    if (i <= kleineZahl)
      print("kleine zahl $i");
    else if (i > kleineZahl && i <= mittlereZahl) {
      print("mittlere Zahl $i");
    } else {
      print("große Zahl $i");
    }
  }
}
