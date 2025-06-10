void main()
{

  int age = 15;
  bool hasParentalConsent = true;
  int movieAgeRating = 16;
  int ageDifferenceWithConsent = 2;
  int years = movieAgeRating - age - ageDifferenceWithConsent;

  int age2 = 13;
  bool hasParentalConsent2 = false;
  int movieAgeRating2 = 16;
  int years2 = movieAgeRating2 - age2 - ageDifferenceWithConsent;


  if(age>movieAgeRating) {

    print("alt genug");
  
  }
  else if(hasParentalConsent  && (age + ageDifferenceWithConsent)<=movieAgeRating) {

    print("alt genug");
  }

  else {



    print("srry du bist zu jung probiere es in $years Jahren nochmal");
  }
 
   if(age2>movieAgeRating2) {

    print("alt genug");
  
  }
  else if(hasParentalConsent2 && age2 + ageDifferenceWithConsent<=movieAgeRating2){

    print("alt genug +$age2");
  }

  else {

    print("srry du bist zu jung probiere es in $years2 Jahren nochmal +age2");
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

