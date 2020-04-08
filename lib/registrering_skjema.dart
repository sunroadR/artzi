
import 'dart:ui';

import 'package:artzi/art.dart';
import 'package:artzi/siste_skjermbilde.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:artzi/main.dart';


class  RegistreringSkjema extends StatefulWidget{




  @override
  final CameraDescription camera;

  Art nyArt;
  Location location;

  bool registret= false;

  RegistreringSkjema(this.nyArt,this.camera,this.location);

  @override
  _RegistreringSkjemaState createState()=> _RegistreringSkjemaState();



}

class _RegistreringSkjemaState extends State<RegistreringSkjema>{


  String name;
  String anttall;
  String sted;
  String kommentar;



  @override
  void initState(){
    super.initState();


  }



  @override
  void dispose(){
    // myController.dispose();

    super.dispose();
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,

        title: RichText(
          text:  TextSpan(

              text: 'Artzi',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28.0),
              children: <TextSpan>[
                TextSpan(text:'for å notere arter tur', style: TextStyle( fontStyle: FontStyle.italic , fontSize: 18.0),),
              ]
          ),

        ),

      ),


      body: Form(
            child: Align(
                alignment: Alignment.center,
                child:  Container(
                  height: (MediaQuery.of(context).size.height),

                 color: Theme.of(context).backgroundColor,
                  child:ListView(
                   children: <Widget>[



                         //   Container(height: 25,),
                           Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 60),
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(
                                  flex:2,

                                  child: Text(' Dato  : '+this.widget.nyArt.getDatoTidspunkt(),
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              ],
                            ),

                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(
                                  flex:2,
                                  // padding: EdgeInsets.only(left: 20,top:45 ,right: 2),

                                  child: Text('Gps- kordinater ',
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(
                                  // padding: EdgeInsets.only(left: 20,top:45 ,right: 2),

                                  child:  Text(' Bredde - grad : '+this.widget.nyArt.breddegrad.toString()+'',

                                    maxLines: 1,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,fontSize: 18,


                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(

                                  child:  Text(' Lengdegrad - grad : '+this.widget.nyArt.lengdegrad.toString()+'',

                                    maxLines: 1,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,fontSize: 18,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Container(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),


                                Expanded(

                                  child: Text('Navn :',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,fontSize: 18
                                    ),
                                  ),
                                ),

                                Expanded(

                                  flex: 2,
                                  child: TextField(
                                    //   controller: myController,

                                      autofocus: true,
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(

                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            //style: BorderStyle.solid,
                                            color: Colors.lightGreen,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(20.0)
                                        ),

                                        hintText: this.widget.nyArt.getName(),
                                        
                                      ),
                                      textInputAction: TextInputAction.next,

                                      onSubmitted: (_)=>FocusScope.of(context).nextFocus(),

                                      onChanged:(text){

                                        this.widget.nyArt.setName(text);




                                      }


                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(right: 18),
                                ),

                              ],
                            ),
                               Container(height: 20,),
                               Row(

                                mainAxisAlignment: MainAxisAlignment.spaceAround,

                                children: <Widget>[
                                Container(
                                padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(

                                child: Text('Antall ',
                                maxLines: 1,
                                style: TextStyle(
                                fontStyle: FontStyle.italic,fontSize: 18
                                ),
                                ),
                                ),

                                Expanded(

                                flex: 2,


                                child: TextField(


                                autofocus: false,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0)

                                ),
                                hintText: this.widget.nyArt.getAntall(),
                                ),
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_)=>FocusScope.of(context).nextFocus(),
                                onChanged:(text){
                                  this.widget.nyArt.setAntall(text);

                                },
                                ),
                                ),

                                Container(
                                padding: EdgeInsets.only(right: 18),
                                ),


                                ],

                                ),

                            Container(height: 20,),

                            Row(
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(
                                  // padding: EdgeInsets.only(left: 20,top:45 ,right: 2),

                                  child: Text('Funn sted ',
                                    maxLines: 1,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,fontSize: 18
                                    ),
                                  ),
                                ),

                                Expanded(
                                  flex:2,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0)

                                        ),
                                        hintText: this.widget.nyArt.getfunnSted(),
                                    ),

                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_)=>FocusScope.of(context).nextFocus(),

                                    onChanged:(text){
                                      this.widget.nyArt.setFunnSted(text);
                                    },
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 18),
                                ),

                              ],
                            ),
                            Container(height: 20,),


                            Row(
                              children: <Widget>[

                                Container(
                                  padding: EdgeInsets.only(left: 24),
                                ),

                                Expanded(
                                  flex:2,
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(20.0)

                                        ),
                                        hintText: this.widget.nyArt.getKommentar(),
                                    ),

                                    textInputAction: TextInputAction.next,
                                    onSubmitted: (_)=>FocusScope.of(context).nextFocus(),

                                    onChanged:(text){
                                      this.widget.nyArt.setKomentar(text);

                                    },
                                  ),
                                ),

                                Container(
                                  padding: EdgeInsets.only(right: 18),
                                ),

                              ],
                            ),
                            Container(height: 20,),


                            Container(height: 20,),



                            Row(
                                children:<Widget>[


                                  Container(
                                    padding: EdgeInsets.only(left: ((MediaQuery.of(context).size.width)/2),top: 8.0),

                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0)
                                      ),
                                      onPressed: (){


                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=> SisteSkjermBilde(  this.widget.camera,  this.widget.nyArt,this.widget.location )));

                                        this.widget.nyArt.setRegistrert();
                                        /** Navigator.push(context, MaterialPageRoute(
                                            builder: (context)=> TakePictureScreen(  this.widget.camera,  this.widget.nyArt, )));*/
                                      },
                                      color: Colors.lightGreen[600],



                                      child: Text('Neste'),

                                    ),),


                                  ///  ),
                                ]
                            )

         ],
                  ),

                )
            ),

          ),

    );
  }

}