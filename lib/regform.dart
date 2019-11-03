import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SiginupFormCard extends StatelessWidget {
  String validation;
  final saveemail;
  final savepwd;
  final savename;
  final mob;
  SiginupFormCard({this.saveemail,this.savepwd,this.validation,this.savename,this.mob});

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }
  String mobValidator(String value) {
    if (value.length < 10) {
      return 'Invalid mobile number';
    } else {
      return null;
    }
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  //save;
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(1000),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Register",
                style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(45),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Name",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextFormField(
                decoration: InputDecoration(
                    hintText: "Full name",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                obscureText: false,
                validator: (value)=>
                value.isEmpty ? validation: null,
                onSaved:savename
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Mobile Number",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextFormField(
                decoration: InputDecoration(
                    hintText: "1234567890",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                obscureText: false,
                validator: (value)=>
                value.isEmpty ? validation: mobValidator(value),
                onSaved:mob
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),



            Text("Email",
                style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: ScreenUtil.getInstance().setSp(26))),
            TextFormField(
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                obscureText: false,
                validator: (value)=>
                value.isEmpty ? validation: emailValidator(value),
                onSaved:saveemail
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Text("Password",
              style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: ScreenUtil.getInstance().setSp(26)),),
            TextFormField(

                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                obscureText: true,
                validator: (value)=>
                value.isEmpty ? validation: pwdValidator(value),
                onSaved: savepwd

            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),


          ],
        ),
      ),
    );
  }
}