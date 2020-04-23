import 'dart:async';

import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:artzi/art.dart';
import 'package:artzi/siste_skjermbilde.dart';
class TakePictureScreen extends StatefulWidget{


  CameraDescription camera;
  Art nyArt;
  Location location;



      TakePictureScreen(this.camera, this.nyArt, this.location );




  @override
  _TakePictureScreenState createState()  => _TakePictureScreenState();


}





class _TakePictureScreenState extends State<TakePictureScreen> {


// variabler som lagrer the CameraController and the Future
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState(){
    super.initState();
    /// Viser det nåværende output fra kamraet,
    ///  oppretter CamereController
    _controller =CameraController(
      widget.camera,
      ///Definere oppløsningen som skal brukes
      ResolutionPreset.medium,

    );
    ///initialserer the controller som retunerer a Future
    _initializeControllerFuture =_controller.initialize();
  }


  @override
  void dispose(){
    /// disponerer av kontroller når widget anordnet
    _controller.dispose();
    super.dispose();

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text:  TextSpan(

              text: 'Artzi',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28.0),
              children: <TextSpan>[
                TextSpan(text:', for å notere arter på tur', style: TextStyle( fontStyle: FontStyle.italic , fontSize: 18.0),),
              ]
          ),

        ),

      ),

      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context,snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            // If the Future is complete, display the previw
           // return CameraPreview(_controller);
            return CameraPreview(_controller);
          }else{
            //otherwise, display a loading indicator
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Construct the path where the image should be saved using the
            // pattern package.
           final path =
           join(
              // Store the picture in the  directory.
               (await getApplicationSupportDirectory()).path,
              //  (await getExternalStorageDirectory()).path,
              '${DateTime.now()}.png',
            );


            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);


            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(path,this.widget.camera,  this.widget.nyArt,
                                                this.widget.location,),
              ),
            );
            print(' Hva er navnet på path '+path);
            GallerySaver.saveImage(path);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {

  final String imagePath;
  final Art nyArt;
  final CameraDescription camera;
  final Location location;
  const DisplayPictureScreen(this.imagePath, this.camera, this.nyArt, this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(         backgroundColor: Theme.of(context).primaryColor,

        title: RichText(
          text:  TextSpan(

              text: 'Artzi, ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28.0),
              children: <TextSpan>[
                TextSpan(text:'for å notere arter tur', style: TextStyle( fontStyle: FontStyle.italic , fontSize: 18.0),),
              ]
          ),

        ),
      ),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body:
          ListView(
            children: <Widget>[
              Stack(
                children:<Widget>[



                 Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,


                        child:  Image.file(File(imagePath),),
    ),




               Positioned(
                 right: 20.0,
                 bottom: 40.0,

                child: FloatingActionButton(
                      heroTag: "button1",
                   child: Icon(Icons.camera_alt),

                   onPressed: (){
                     Navigator.push(context, MaterialPageRoute(
                         builder: (context)=> TakePictureScreen(this.camera,this.nyArt,this.location )));


                   },

                 ),



               ),
                  new Divider(),

                  Positioned(
                    left: 20.0,
                    bottom: 40.0,

                    child: FloatingActionButton(
                    heroTag: "button2",
                      child: Icon(Icons.check),

                      onPressed: (){

                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> SisteSkjermBilde( this.camera,  this.nyArt,this.location )));


                      },

                    ),



                  ),






    ]
              ),
            ],
          ),





    );
  }
}






