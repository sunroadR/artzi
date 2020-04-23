/**
 * Objekt av klasseen lagrer infoen som blir notert om arten
 */
class Art {

  String name='Skriv inn navn på art';
   String antall='Skriv inn anttall';
  String funnSted='Skriv inn på funn sted';
  String kommentar='Eventuelle andre\n kommentarer';
  String DatoTidspunkt='';
  bool registrert=false;



  double breddegrad;
  double lengdegrad;

  Art(double bredde, double lengde){
    this.breddegrad=bredde;
    this.lengdegrad= lengde;
  }

  String getName() => name;
   String getAntall() => antall;
  String getfunnSted() => funnSted;
  String getKommentar() => kommentar;
  String getDatoTidspunkt() => DatoTidspunkt;

  
  String getLengdegrad() => lengdegrad.toString();
  String getBreddegrad() => breddegrad.toString();

  bool getRegistrert()=> registrert;


  void setDatoTidspunk(String tidspkt){
    this.DatoTidspunkt=tidspkt;
  }
  void setName(String oppgittNavn){
    this.name=oppgittNavn;
  }


      void setAntall(String oppgittAntall){
      this.antall=oppgittAntall;

      }

  void setFunnSted(String oppgittFunnSted){
    this.funnSted=oppgittFunnSted;
  }

  void setKomentar(String oppgittKpmentar){
    this.kommentar=oppgittKpmentar;
  }
void setRegistrert(){
    this.registrert=false;
}


}