import 'dart:async';
//import 'dart:html';
//import 'package:universal_html/html.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:io' as io;
import 'dart:io';

import 'package:artzi/art.dart';
import 'package:artzi/registrering_skjema.dart';
import 'package:artzi/read_write_file.dart';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:date_format/date_format.dart';
import 'package:path_provider/path_provider.dart';



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
  nyArt = new Art(_locationData.latitude,_locationData.longitude);



  runApp(
      MaterialApp(

        theme: ThemeData(


            primaryColor: Colors.lightGreen,
            backgroundColor: Colors.lightGreen[100],
            accentColor: Colors.lightGreen[700],
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
            accentColor: Colors.lightGreen[700],
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

  String tid;
  String gps;
  String navn;
  String antall;
  String funnsted;
  String kommentar;


  bool _load = false;
  Timer _timer;

  void setLoad() {
    _load = false;
  }

  @override
  Widget build(BuildContext context) {

    Widget loadingIndicator = _load ? new Container(
      color: Theme
          .of(context)
          .backgroundColor,
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: new Center(
          child: new CircularProgressIndicator(
          )
      ),

    ) : new Container();

    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: RichText(
            text: TextSpan(

                text: 'Artzi',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
                children: <TextSpan>[
                  TextSpan(text: ', for å notere arter på tur',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, fontSize: 18.0),),
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
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 2,
                  color: Theme
                      .of(context)
                      .backgroundColor,

                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  //     child:Padding(
                  //      padding: EdgeInsets.only(right:25, bottom: 30),
                  child: Align(
                      alignment: Alignment.center,

                      child: _load ? Center(
                        child: CircularProgressIndicator(),
                      ) : new RaisedButton(

                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        color: Colors.lightGreen[300],
                        child: Text('Starte ny registrering',
                            style: TextStyle(fontSize: 20)),

// Within the `FirstRoute` widget
                        onPressed: () async {
                          setState(() {
                            _load = true;
                          });

                          String tidsPkt = formatDate(DateTime.now(),
                              [dd, '.', mm, '.', yyyy, '  ', HH, ':', nn]);


                          this.widget._locationData =
                          await this.widget.location.getLocation();
                          this.widget.nyArt = new Art(
                              this.widget._locationData.latitude,
                              this.widget._locationData.longitude);
                          this.widget.nyArt.setDatoTidspunk(tidsPkt);


                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                  RegistreringSkjema(
                                      this.widget.nyArt, this.widget.camera,
                                      this.widget.location)));


                          setState(() {
                            _timer = new Timer(const Duration(
                                microseconds: 400), () {
                              _load = false;
                            });
                          });
                        },

                      )
                  ),
                  // ),
                ),


              ],


            ),


            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              color: Theme
                  .of(context)
                  .backgroundColor,


              child: Align(
                  alignment: Alignment.center,


                  child: RaisedButton(

                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      color: Colors.lightGreen[300],
                      child: Text('Se tidligere notater',
                          style: TextStyle(fontSize: 20)),
                      // Within the `FirstRoute` widget
                      onPressed: () async {
                        ReadWriteFile lese = new ReadWriteFile();


                        File notaterFil = await lese.getFile();


                        bool finnes = await notaterFil.exists();
                        if (finnes == false) {
                          showDialog(context: context,


                              builder: (BuildContext context) {
                                return AlertDialog(


                                  title: Text('Ingen notater registrert'),

                                );
                              }
                          );
                        }
                        else {



                          String  notat = await lese.readAsString();
                         showDialog(context: context,



                          builder: (BuildContext context) {




                              return AlertDialog(


                                title: Text('Tidligere notater',style: TextStyle(color: Theme.of(context).accentColor,
                                fontSize: 18),),
                                content: SingleChildScrollView(

                                  child: ListBody(
                                    children: <Widget>[

                                    Text(''+notat.toString()),

                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                FlatButton(
                                  child: Text('Dele',style: TextStyle(color: Theme.of(context).accentColor,
                                  fontSize: 18,fontWeight:FontWeight.bold ),),
                                  onPressed: (){
                                    lese.dele();
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context)=> MyHomePage(this.widget.camera,this.widget.nyArt,this.widget.location, )));

                                    lese.slettFile();
                                  },

                                ),
                                  FlatButton(
                                    child: Text('OK',style: TextStyle(color: Theme.of(context).accentColor,
                                        fontSize: 18,fontWeight:FontWeight.bold ),),
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context)=> MyHomePage(this.widget.camera,this.widget.nyArt,this.widget.location, )));
                                    },

                                  ),
                                ],


                              );
                            },
                          );
                        }
                      }
                  )


              ),

            ),

          ],
        ),


        // This trailing comma makes auto-formatting nicer for build methods.
      );
  }





String getTid()=> tid;

  void setTid(String s) {
    this.tid =tid;
  }





}


