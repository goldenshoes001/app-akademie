class Sebilist<T> {
  List<T> sebiList = [];

  
  void operator []=(int index, T value) {
    sebiList[index] = value;
  }

  T operator [](int index) {
    return sebiList[index];
  }

  void add(T item) {
    if (!sebiList.contains(item)) sebiList.add(item);
  }

  int length() {
    return sebiList.length;
  }

  List<dynamic> removeElement(dynamic element) {
    List<T> newList = [];

    if (sebiList.contains(element)) {
      for (int i = 0; i < sebiList.length; i++) {
        if (sebiList[i] != element) {
          newList.add(sebiList[i]);
        }
      }
      this.sebiList = newList;
    }
    return sebiList;
  }

  List<dynamic> removeElementIndex(int index) {
    List<T> newList = [];

    if (sebiList.length > index) {
      for (int i = 0; i < sebiList.length; i++) {
        if (index != i) {
          newList.add(sebiList[i]);
        }
      }
      this.sebiList = newList;
    }
    return sebiList;
  }

  // Eine Methode, um ein Element nach Index abzurufen (Alternative zu operator[])
  T getElementAtIndex(int index) {
    return sebiList[index];
  }

  dynamic SearchIndex(dynamic element) {
    if (sebiList.contains(element)) {
      for (int i = 0; i < sebiList.length; i++) {
        if (sebiList[i] == element) {
          return i;
        }
      }
    }
  }

  bool contains(dynamic element) {
    if (this.sebiList.contains(element))
      return true;
    else {
      return false;
    }
  }

  @override
  String toString() {
    return sebiList.join(",");
  }
}
