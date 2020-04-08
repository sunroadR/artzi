import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';


import 'package:artzi/art.dart';
import 'package:share_extend/share_extend.dart';

class ReadWriteFile{
  
  void skrivNotatOmArt(Art nyArt)async{
    String info;
    info=await' Dato og tidspunkt '+nyArt.getDatoTidspunkt()+'§ \n Gps - kordinator :\n'
        'Lengde-grad :'+nyArt.getLengdegrad()+'§\nBreddde-grad :'+nyArt.getBreddegrad()+'§\n '
        'Navn : '+nyArt.getName()+'§ Antall : '+nyArt.getAntall()+'§ \n Funnsted :'+nyArt.getfunnSted()+'§'
        'Komentar '+nyArt.getKommentar()+'\n';

    writeInfo(info);

  }

  ///Path to the documents directory
  Future<String> get _localPath async {
   final directory = await getExternalStorageDirectory();
    return directory.path;
  }

  /// Create reference to the file´s full location
   Future<File> get _localFile async{
    final path = await _localPath;

    return File( '$path/art_registret.txt');
   }

   /// writes to the file
   Future<File> writeInfo(String info) async {
    final file = await _localFile;
    // Write the file
    print("file://${file.path}");

    return file.writeAsString(info, mode: FileMode.append);
   }

  /// Reads from the file

  Future<String> read() async {
    final file = await _localFile;
    // ignore: unnecessary_statements
    Stream<List<int>> inputStream = file.openRead();
    inputStream
        .transform(utf8.decoder) // Decode bytes to UTF-8
        .transform(new LineSplitter()) //Convert stream to individual lines

        .listen((String line) {
        int i=0;
while( i<5){
print('${line.split('§').elementAt(i)} ');
i++;
      }


  },
        onDone: () {
          print('File is now closd');
        },
        onError: (e) {
          print(e.toString());
        });
  }
 /**Future<String> read() async {
   String text;
    try {
      final file = await _localFile;
      //Read the file
      text =await file.readAsString();

      print('Her er Jeg , hvor er du ?'+text);



    }catch(e){
      return 'Fikk ikke lest filen';
    }
   return text;

 }*/

 void dele() async{

    Directory dir = await getApplicationDocumentsDirectory();

    File notaterFil = new File('${dir.path}/art_registret.txt');

    if(!await notaterFil.exists()){
      await notaterFil.create(recursive: true);
      String info = await read();
      notaterFil.writeAsStringSync(info);
    }

    ShareExtend.share(notaterFil.path, "file");


 }


Future<File> getFile(){
    return _localFile;
}



}