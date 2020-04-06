
class Art {

  String name='';
   String antall="";
  String funnSted='';
  String kommentar='';
  String DatoTidspunkt;



  double breddegrad;
  double lengdegrad;

  Art(double bredde, double lengde){
    this.breddegrad=bredde;
    this.lengdegrad= lengde;
    this.DatoTidspunkt='';
  }

  String getName() => name;
   String getAntall() => antall;
  String getfunnSted() => funnSted;
  String getKommentar() => kommentar;
  String getDatoTidspunkt() => DatoTidspunkt;
  
  String getLengdegrad() => lengdegrad.toString();
  String getBreddegrad() => breddegrad.toString();


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



}