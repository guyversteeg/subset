/*
    Auteur:  Guy Versteeg
    Casus Subset
 */

int wBreedte = 900;
int wHoogte = 950;
//Array met alle mogelijke eigenschappen van de kaarten.
String[] eigenschappen = {"1", "2", "3", "r", "g", "b", "r", "e", "d"};
String[] kaarten = new String[27];
int nGedekteKaarten = 26;
int nGeselecteerdePosities = 0;
String[] gedekteKaarten = new String[27];
String[] kandidaatset = new String[9] ;
String[] kaartenOpTafel = new String[9];
int score = 0;
String kaart = "";
int vakBreedte = 98;
int vakHoogte = vakBreedte;


void setup() {
    size(wBreedte, wHoogte);
    background(#068944);
    tekenBord();
    //De array kaarten wordt gevuld door genereerKaarten(eigenschappen)
    kaarten = genereerKaarten(eigenschappen);
    //De array kaarten wordt nu geschud, zodat alle kaarten op een random plek in de array staan.
    kaarten = schudKaarten(kaarten);
    printArray(kaarten);
    printArray(gedekteKaarten());
    println(pakKaartVanStapel(kaarten));
    int bordpositie = 1;
    println(kaart);
    if (kaart != null) {
    kaart = pakKaartVanStapel(kaarten);
    tekenKaart(kaart, bordpositie);
        for(int x = 0; x < 9; x++) {
        kaartenOpTafel[x]   = pakKaartVanStapel(kaarten);
        tekenKaart(kaartenOpTafel[x], x);
    }        
    } else {
      println("Whoops");  
    }
}

void draw() {
    weergeefScore();
}

//Functie die alle mogelijke kaarten gaat genereren.
//Precondition
//Postcondition
String[] genereerKaarten(String[] eigenschappen) {
    String[] combinaties = new String[27];
    int index = 0;
    for (int i=0; i < 3; i++) {
      String eigenschapNummers = eigenschappen[i];
      for (int j=3; j < 6; j++) {
        String eigenschapKleur = eigenschappen[j];
        for (int k=6; k < eigenschappen.length; k++) {
          String eigenschapVorm = eigenschappen[k];
          String gegenereerdeEigenschappen  = eigenschapNummers + eigenschapKleur + eigenschapVorm;
          combinaties[index] = gegenereerdeEigenschappen;
          index++;
        }
      }
    }
    return combinaties;
} 

//Functie die de kaarten gaat schudden.
//Pre-conditie: Kaarten zijn aangemaakt.
//Post-conditiie: Kaarten zijn geschud.
String[] schudKaarten(String[] kaarten) {
    for(int i = 0; i < 1000; i++) {
    float random1 = round(random(0,26));
    int rand1 = int(random1);
    float random2 = round(random(0,26));
    int rand2 = int(random2);
    //println(rand1); Kijkt of de waardes goed afgerond worden.
    String kaartenRandom = kaarten[rand1];
    kaarten[rand1] = kaarten[rand2];
    kaarten[rand2] = kaartenRandom;
    }
    return kaarten;
}


//Functie die het raster tekent.
//Pre-conditie: Er is een leeg bord.
//Post-conditie: Er is een raster aangebracht
void tekenRaster() {
    line(0, wHoogte / 3, wBreedte - 1, wHoogte / 3);
    line(0, wHoogte - (wHoogte / 3), wBreedte - 1, wHoogte - (wHoogte / 3));
    line(0, wHoogte - 50, wBreedte - 1, wHoogte - 50);
    line(wBreedte / 3, 0, wBreedte / 3, wHoogte - 50);
    line(wBreedte - (wBreedte / 3), 0, wBreedte - (wBreedte / 3), wHoogte - 50);
}

void tekenBord() {
    tekenRaster();
}

//De functie die aangeeft hoeveel kaarten er nog gedekt zijn, ofwel hoeveel kaarten er nog niet in het spel zijn.
String[] gedekteKaarten() {
    String[] gedekteKaarten = kaarten;
    return gedekteKaarten;
}

//De functie die bijhoudt hoeveel kaarten er nog gedekt zijn.
//int nGedekteKaarten(String[] gedekteKaarten) {
    //int test = 0;
    //return test;
//}

//De functie die de kaarten op het bord moet leggen.
String pakKaartVanStapel(String[] kaarten) {
    //Pak de laatste entry uit gedekteKaarten
    String test = "";
    if(nGedekteKaarten > 0) {
        kaarten[nGedekteKaarten] = gedekteKaarten[nGedekteKaarten];
        nGedekteKaarten--;
        test = kaarten[nGedekteKaarten];  
    }
    else {
        println("Er zijn geen kaarten meer in het spel");
    }
    //println(test);
    return test;
}

/*
    De functie die bij de kaartcode het bijbehorende plaatje laadt.
    Pre-conditie: Er is nog geen kaart zichtbaar op het scherm.
    Post-Conditie: De kaarten zijn zichtbaar op het scherm.
*/
void tekenKaart(String kaart, int bordpositie) {
    println(kaart);
    PImage img = null;
    if (kaart != null) {
      img = loadImage(kaart + ".jpg");  
      image(img, vakBreedte * bordpositie, vakHoogte); 
      //tekenKaart(kaartenOpTafel[bordpositie], bordpositie);
    } else {
      println("Should never happen"); 
    }
}


/*
Pre-conditie: Er is nog niet bekend of de kaartencombinatie een set is.
Post-conditie: Indien de kaartencombinatie een set is, is de score verhoogd met 1.
boolean isSet(String[] kandidaatset) {
    isSet = false;
    if(kaartencombinatie == kandidaatset) {
    isSet = true;
    score++;
    }
    else
    isSet = false;
}
*/

/*
    Deze functie zorgt voor de weergave van de score op het scherm.
    Pre-conditie: De score begint met 0 en wordt opgehoogd, wanneer er een set geselecteerd is.
    Post-conditie: De score wordt weergegeven op het scherm.
*/    
void weergeefScore() {
 text("Score: " + score, 30, 930); 
}



