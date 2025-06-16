import 'SebiList.dart';

void main() {
  Sebilist item = new Sebilist();

  item.add("hallo");
  item.add(2);
  item.add("test");

  item.removeElement(2);
  item.removeElementIndex(1);

  print(item);
}
