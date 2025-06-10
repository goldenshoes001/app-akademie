void main()
{

  int age = 15;
  bool hasParentalConsent = true;
  int movieAgeRating = 16;
  int ageDifferenceWithConsent = 2;
  int years = movieAgeRating - age - ageDifferenceWithConsent;

 

 //test 1
  if(age>movieAgeRating) {
    print("alt genug");
  }
  else if(hasParentalConsent  && (age + ageDifferenceWithConsent)<=movieAgeRating) {
    print("alt genug");
  }
  else {
    print("srry du bist zu jung probiere es in $years Jahren nochmal");
  }
 
if(age>movieAgeRating) {
    print("alt genug");
    }
  else if(hasParentalConsent  && (age + ageDifferenceWithConsent)<=movieAgeRating) {
    print("alt genug");
  }

  else {
    print("srry du bist zu jung probiere es in $years Jahren nochmal");
  }


  //Test 2
  age = 13; 
  hasParentalConsent = false; 
  movieAgeRating = 16;

 if(age>movieAgeRating) {
    print("alt genug");
  }
  else if(hasParentalConsent  && (age + ageDifferenceWithConsent)<=movieAgeRating) {
    print("alt genug");
  }
  else {
    print("srry du bist zu jung probiere es in $years Jahren nochmal");
  }
 


  //aufgabe 2
bool isLoggedIn = true;
bool isbanned = false;
bool isSubscribed = true;
int age3 = 18;

if(isLoggedIn == false) {

print("Bitte logge dich ein");
}
if(isbanned == true) {
  print("Dein Account wurde gesperrt");
}
if(isSubscribed == false) {
  print("bitte abboniere");
}
if(age3>18) {
  print("Du bist zu jung");
}

else {
  print("Wilkommen");
}
}

