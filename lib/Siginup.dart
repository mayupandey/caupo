import 'package:cloud_firestore/cloud_firestore.dart';

import 'ProfilePage.dart';
import 'regform.dart';
import 'CustomIcons.dart';
import 'SocialIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';


class Siginup extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<Siginup> {
  _MyAppState({FirebaseAuth firebaseAuth, GoogleSignIn googleSignin})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;

  String _email;
  String   _password;
  String _name;
  String _mobile;
  final formkey=new GlobalKey<FormState>();
  checkFields(){
    final form=formkey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  Future<void> signUp({String email, String password}) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
  }
  createUser()async{
    if (checkFields()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)
      //firestoresave details
      .then((user)=>Firestore.instance
      .collection("users")
      .document(user.uid)
      .setData({
        "uid":user.uid,
        "name":_name,
        "email":_email,
        "mobile":_mobile,


      }))
      //navigate to another page
          .then((result){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }).catchError((e){
        print(e);
      });
    }
  }
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                    height: 280,
                    child: Image.asset("assets/mckprice.gif")),
              ),
              Expanded(
                child: Container(),
              ),

            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  Column(

                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("Create account",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold)),

                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(320),
                  ),
                  Form(
                      key: formkey,
                      child: SiginupFormCard(
                        validation: 'required',
                        saveemail: (value) => _email = value,
                        savepwd: (value) => _password = value,
                        savename: (value)=>_name=value,
                        mob: (value)=>_mobile=value,

                      )),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 12.0,
                      ),

                      SizedBox(
                        width: 8.0,
                      ),

                    ],
                  ),
                  Center(
                    child: InkWell(
                      onTap: signUp,
                      child: Container(
                        width: ScreenUtil.getInstance().setWidth(330),
                        height: ScreenUtil.getInstance().setHeight(100),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea)
                            ]),
                            borderRadius: BorderRadius.circular(6.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF6078ea).withOpacity(.3),
                                  offset: Offset(0.0, 8.0),
                                  blurRadius: 8.0)
                            ]),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: createUser,
                            child: Center(
                              child: Text("SIGNUP",
                                  style: TextStyle(

                                      color: Colors.white,
                                      fontFamily: "Poppins-Bold",
                                      fontSize: 18,
                                      letterSpacing: 1.0,
                                        )),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "By signing up your are agrreing from our  ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> Siginup()));
                        },
                        child: Text("Terms & Condition and Privacy Policy",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
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