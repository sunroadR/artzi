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
  print('her er gps : ' + _locationData.toString());
  nyArt = new Art(_locationData.latitude,_locationData.longitude,
      ''+DateTime.now().toLocal().toString()+'');



  runApp(
      MaterialApp(
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
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.lightGreen,
        ),
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
    var appBar =AppBar();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
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


                  Container(
                   color: Colors.lightGreen[100],
                     child: Row(
                children: <Widget>[

                       Expanded(
                          child: Column(
                             mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          Container(
                            color: Colors.lightGreen[100],

                            height: (MediaQuery.of(context).size.height-appBar.preferredSize.height)/2,
                            // width: MediaQuery.of(context).size.width/2,


                            child: Container(
                              height: 50.0,

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


                                    //            Navigator.push(context, MaterialPageRoute(
                                    //              builder: (context)=> TakePictureScreen(  this.widget.camera,  this.widget.nyArt, )));

                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => RegistreringSkjema(this.widget.nyArt,this.widget.camera,this.widget.location)));

                                    // Navigator.push(context,



                                  },
                                ),
                              ),
                              // ),
                            ),


                          ),
                        ]
                    ),
                  )                 ],



              ),
            ),







               Column(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    Container(
                      color: Colors.lightGreen[100],

                      height: (MediaQuery.of(context).size.height-appBar.preferredSize.height)/2,
                      // width: MediaQuery.of(context).size.width/2,


                      child: Container(
                        height: 100.0,


                        // width: MediaQuery.of(context).size.width,
                        //  child:Padding(
                        //   padding: EdgeInsets.only(right:25, bottom: 150),
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

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Container(

                                    color: Colors.lightGreen[100],
                                    child: AlertDialog(

                                      backgroundColor: Colors.lightGreen[300],
                                      title: Text('Navn på art registrert art :  '+navnArt.toString()),
                                    ),
                                  ),
                                  )
                              );

                            },
                          ),
                        ),
                        // ),
                      ),


                    ),
                  ]
              ),
    ],
        ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


