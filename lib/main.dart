import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() {
  runApp(ReadApp());
}

class ReadApp extends StatefulWidget {
  const ReadApp({Key? key}) : super(key: key);

  @override
  _ReadAppState createState() => _ReadAppState();
}

class _ReadAppState extends State<ReadApp> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String content = '';
  @override
  void initState() {
    super.initState();
    getAccess();
  }

  getAccess() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var status2 = await Permission.manageExternalStorage.status;
    if (!status2.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    var status3 = await Permission.accessMediaLocation.status;
    if (!status3.isGranted) {
      await Permission.accessMediaLocation.request();
    }
    final directory =
        (await Directory('storage/emulated/0/SharingFolder').create()).path;
    final file = File('$directory/hehe.txt');
    content = await file.readAsString();
    print(content);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(content),
      ),
    ));
  }
}
