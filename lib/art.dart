
class Art {

  String name='';
  // String antall;
  String funnSted='';
  String kommentar='';
  String DatoTidspunkt;


  double breddegrad;
  double lengdegrad;

  Art(this.breddegrad,this.lengdegrad, this.DatoTidspunkt);

  String getName() => name;
  // String getAntall() => antall;
  String getfunnSted() => funnSted;
  String komentar() => kommentar;
  String getDatoTidspunkt() => DatoTidspunkt;


  void setName(String oppgittNavn){
    this.name=oppgittNavn;
  }

  /**
      void setAntall(String oppgittAntall){
      this.antall=oppgittAntall;

      }*/

  void setFunnSted(String oppgittFunnSted){
    this.funnSted=oppgittFunnSted;
  }

  void setKomentar(String oppgittKpmentar){
    this.kommentar=oppgittKpmentar;
  }



}