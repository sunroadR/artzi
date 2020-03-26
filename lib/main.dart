import 'dart:async';

import 'package:artzi/art.dart';
import 'package:artzi/registrering_skjema.dart';
import 'package:artzi/read_write_file.dart';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';


Future<void> main() async{

  Art nyArt;

  // sjekker at plugin service er  initialisert slik at app foår tak i kamera før den kjører
  WidgetsFlutterBinding.ensureInitialized();

  // Få tak i til tilgjengelige camera på device
  final cameras = await availableCameras();

  // henter et gitt kamera fra listen
  final firstCamera = cameras.first;

// sjekker manuelt location service status og permission status
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if(!_serviceEnabled){
    _serviceEnabled =await location.requestService();
    if(!_serviceEnabled){
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if(_permissionGranted == PermissionStatus.DENIED){
    _permissionGranted = await location.requestPermission();
    if(_permissionGranted != PermissionStatus.GRANTED){
      return;
    }

  }


  _locationData = await location.getLocation();
  nyArt = new Art(_locationData.latitude,_locationData.longitude,
      ''+DateTime.now().toLocal().toString()+'');



  runApp(
      MaterialApp(

        theme: ThemeData(


            primaryColor: Colors.lightGreen,
            backgroundColor: Colors.lightGreen[100],
            accentColorBrightness: Brightness.dark
        ),


        home: MyApp(
          camera: firstCamera,
          nyArt: nyArt,
          location: location,


        ),
      )
  );
}

class MyApp extends StatelessWidget {


  final CameraDescription camera;
  final Art nyArt;
  Location location;


  MyApp({
    Key key,
    @required this.camera,
    this.nyArt,
    this.location,
  }) :super(key:key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       theme: ThemeData(


            primaryColor: Colors.lightGreen,
            backgroundColor: Colors.lightGreen[100],
            accentColorBrightness: Brightness.dark,



        ),
        title: 'Flutter Demo',

        home: MyHomePage(

            camera,
            nyArt,
            location




        ));
  }
}

class MyHomePage extends StatefulWidget {


  CameraDescription camera;
  Art nyArt;
  Location location;
  LocationData _locationData;

  MyHomePage(CameraDescription etcamera, Art enArt, Location onelocation){

    this.camera=etcamera;
    this.nyArt=enArt;
    this.location=onelocation;


  }





  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
   // var appBar =AppBar(
    //);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: RichText(
            text:  TextSpan(

                text: 'Artzi',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28.0),
                children: <TextSpan>[
                  TextSpan(text:', for å notere arter på tur', style: TextStyle( fontStyle: FontStyle.italic , fontSize: 18.0),),
                ]
            ),

          ),



        ),


        body: ListView(

          children: <Widget>[


                  //Container(


                     Row(
                children: <Widget>[


                          Container(
                            height: MediaQuery.of(context).size.height/2,
                            color: Theme.of(context).backgroundColor,

                              width: MediaQuery.of(context).size.width,
                              //     child:Padding(
                              //      padding: EdgeInsets.only(right:25, bottom: 30),
                              child: Align(
                                alignment: Alignment.center,

                                child: RaisedButton(

                                  shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(30.0),
                                  ),
                                  color: Colors.lightGreen[300],
                                  child: Text ('Starte NY registrering',
                                      style: TextStyle(fontSize: 20)),
// Within the `FirstRoute` widget
                                  onPressed: () async {

                                    String tidsPkt= formatDate(DateTime.now(), [dd,'.',mm,'.',yyyy, '  ',HH,':',nn]);

                                    print('Tid på dagen: '+tidsPkt.toString());


                                    this.widget._locationData= await this.widget.location.getLocation();
                                    this.widget.nyArt = new Art(this.widget._locationData.latitude,this.widget._locationData.longitude,
                                        tidsPkt);



                                    print('Tid på dagen: '+tidsPkt.toString());


                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => RegistreringSkjema(this.widget.nyArt,this.widget.camera,this.widget.location)));

                                    // Navigator.push(context,



                                  },
                                ),
                              ),
                              // ),
                            ),




      ],



              ),


               Container(
                 height: MediaQuery.of(context).size.height/2,
                 color: Theme.of(context).backgroundColor,


                child: Align(
                  alignment: Alignment.center,

                  child: RaisedButton(

                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    color: Colors.lightGreen[300],
                    child: Text ('Se tidligere registrete arter',
                        style: TextStyle(fontSize: 20)),
// Within the `FirstRoute` widget
                    onPressed: () async{
    ReadWriteFile lese = new ReadWriteFile();
    var navnArt;

    navnArt = await lese.read();

    String datoTid = getTidDato(navnArt.toString());
    String lengdegrad= getLegdegrad(navnArt.toString());
    String breddegrad =getBreddegrad(navnArt.toString());
    String navn = getNavn(navnArt.toString());
    String funnsted = getFunnSted(navnArt.toString());
    String kommentar = getKommentar(navnArt.toString());

    showDialog(context: context,


    builder:(BuildContext context){
    return AlertDialog(


    title: Text('Navn på arter registrert'),
    content: SingleChildScrollView(
    child: ListBody(
    children: <Widget>[


    //  title: Text('Navn på art registrert art : \n '+navnArt.split('/').toString()+'\n'),
    Text('Dato & tid : '+datoTid.toString()),
    Text('Gps-kordinater :\n '+lengdegrad.toString()+' & '+breddegrad.toString()),
    Text( 'Navn : '+navn.toString()),
    Text(' Funnsted : '+funnsted.toString()),
    Text( 'Kommentar : '+kommentar.toString()),

    ],
    ),
    ),
    );


    },


    );

    }
    ),
    ),
               ),

    ],
        ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  /// Metoder som  henter ut registret info om  registrerte arter
String getTidDato(String info){
    return info.split("§").elementAt(0);
}

String getLegdegrad(String info){
    return info.split("§").elementAt(1);
  }

  String getBreddegrad(String info){
    return info.split("§").elementAt(2);
  }

  String getNavn(String info){
    return info.split("§").elementAt(3);
  }

  String getFunnSted(String info){
    return info.split("§").elementAt(4);
  }

 String getKommentar(String info){
   return info.split("§").elementAt(5);

 }
}


