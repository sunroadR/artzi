import 'dart:ui';

import 'package:artzi/art.dart';
import 'package:artzi/main.dart';
import 'package:artzi/take_picture_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';



class SisteSkjermBilde extends StatelessWidget {


  CameraDescription camera;
  Art nyArt;
  Location location;

  SisteSkjermBilde(CameraDescription etCamera, Art art,Location oneLocation ,{Key key}) {
    // Key key;
    // super;(key:key);
    this.camera = etCamera;
    this.nyArt = art;
    this.location=oneLocation;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(

              text: 'Artzi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.0),
              children: <TextSpan>[
                TextSpan(text: 'for å notere arter tur',
                  style: TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 18.0),),
              ]
          ),

        ),

      ),
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              height: (MediaQuery.of(context).size.height),
              color: Colors.lightGreen[100],
              child: Column(
                children: <Widget>[
                  Container(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 24),
                      ),
                      Expanded(
                          flex: 2,
                          child: Text(' Vil du ta bilde \n av '+this.nyArt.getName(),style: TextStyle(
                            fontStyle: FontStyle.italic,fontSize: 18,
                          ),
                          )

                      ),
                      Expanded(
                        flex: 2,
                        child: FloatingActionButton(
                          child: Icon(Icons.camera_alt),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> TakePictureScreen(  this.camera,  this.nyArt, )));
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(height: 200,),
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: Align(
                          alignment: Alignment.center,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: Colors.lightGreen[600],
                            child: Text ('Ferdig',
                                style: TextStyle(fontSize: 20)),
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=> MyHomePage(camera,nyArt,location, )));
                            },
                          ),
                        ),

                      )
                    ],
                  )
                ],
              ),

            ),
          )
        ],
      ),

    );
  }
}
