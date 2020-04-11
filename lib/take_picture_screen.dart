import 'dart:async';

import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:artzi/art.dart';
class TakePictureScreen extends StatefulWidget{


  CameraDescription camera;
  Art nyArt;

  TakePictureScreen(CameraDescription etCamera, Art art, {Key key}) {
    // Key key;
    // super;(key:key);
    this.camera=etCamera;
    this.nyArt =art;


  }




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
            final path = join(
              // Store the picture in the  directory.

                (await getExternalStorageDirectory()).path,
              '${DateTime.now()}.png',
            );

            // Attempt to take a picture and log where it's been saved.
            await _controller.takePicture(path);

            // If the picture was taken, display it on a new screen.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
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

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}






