class Benutzer {
  String username;
  String alter;
  String email;
  String passwort;

  Benutzer(this.username, this.alter, this.email, this.passwort);
}

class Deck {
  String deckThema;
  String deckName;
  List<MaindeckMonsterkarte> yugiohListeMonsterkarte;
  List<Zauberkarte> yugiohListeZaubertarten;
  List<Fallenkarte> yugiohListeFallenkarten;

  Deck(this.deckThema,this.deckName,this.yugiohListeMonsterkarte,this.yugiohListeZaubertarten,this.yugiohListeFallenkarten
  );
}

class MaindeckMonsterkarte {
  String name;
  String eigenschaft;
  String atribut;
  String monstertyp;
  String bildPfad;

  MaindeckMonsterkarte(
    this.name,
    this.monstertyp,
    this.eigenschaft,
    this.atribut,
    this.bildPfad,
  );
}

class Zauberkarte {
  String name;
  String kartenTyp;
  String bildPfad;

  Zauberkarte(this.name, this.kartenTyp, this.bildPfad);
}

class Fallenkarte {
  String name;
  String kartenTyp;
  String bildPfad;

  Fallenkarte(this.name, this.kartenTyp, this.bildPfad);
}

class Deckliste {
  List<Deck> Decklisten;

  Deckliste(this.Decklisten);
}
