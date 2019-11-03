import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/services.dart';

import 'firbase.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() {
    return new ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {

  String result = "Hey there scan qr code placed on table!";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;

       var aa=
            MaterialPageRoute(
                builder: (context)=>FirstRoute(
              val:result,
        ));
       Navigator.of(context).push(aa);
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";


        });
      } else {
        setState(() {

          result = "Unknown Error $ex";


        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";

      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
       child:Text(
              result
       )
        /*child: Container(

         child:Image.asset('assets/images/qr.gif'),

       ),*/
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}