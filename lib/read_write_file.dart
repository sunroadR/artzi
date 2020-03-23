import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ReadWriteFile{

  ///Path to the documents directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// Create reference to the file´s full location
   Future<File> get _localFile async{
    final path = await _localPath;
    return File( '$path/counter.txt');
   }

   /// writes to the file
   Future<File> writeInfo(String info) async {
    final file = await _localFile;
    // Write the file
     return file.writeAsString(info);
   }

  /// Reads from the file
 Future<String> read() async {
   String text;
    try {
      final file = await _localFile;
      //Read the file
      text =await file.readAsString();



    }catch(e){
      return 'Fikk ikke lest filen';
    }
   return text;

 }


}