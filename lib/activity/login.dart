import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yaamfoo/activity/OtpVerify.dart';
import 'package:yaamfoo/activity/SignUp.dart';
import 'package:yaamfoo/comman/ApiConstant.dart';
import 'package:yaamfoo/comman/CustomProgressLoader.dart';
import 'package:yaamfoo/comman/ToastWrap.dart';
import 'package:yaamfoo/constant/Constant.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'ForgotPassword.dart';
import 'package:yaamfoo/values/ColorValues.dart';
import 'StartScreen.dart';

class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  int _counter = 0;
  bool obscureText = true, passwordVisible = false,
      mobileVisible = false;

  String reply="";
  String _mobile, _password;
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  String _message = 'Log in/out by pressing the buttons below.';
  Future<Null> _login() async {
    final FacebookLoginResult result =
    await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        _showMessage('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        break;
      case FacebookLoginStatus.cancelledByUser:
        _showMessage('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        _showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }

  Future<Null> _logOut() async {
    await facebookSignIn.logOut();
    _showMessage('Logged out.');
  }

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseAuth _auth;
  bool isUserSignedIn = false;
  void _showMessage(String message) {
    setState(() {
      _message = message;
    });
  }


  Future<bool> _onWillPop() {
    Navigator.pushReplacement(context,
        new MaterialPageRoute(builder: (BuildContext context) => StartScreen()));
  }
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPreferences();
    initApp();
  }

  void initApp() async {
    FirebaseApp defaultApp = await Firebase.initializeApp();
    _auth = FirebaseAuth.instanceFor(app: defaultApp);
    checkIfUserIsSignedIn();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });
  }

  Future<User> _handleSignIn() async {
    User user;
    bool userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      isUserSignedIn = userSignedIn;
    });

    if (isUserSignedIn) {
      user = _auth.currentUser;
    }
    else {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
      userSignedIn = await _googleSignIn.isSignedIn();
      setState(() {
        isUserSignedIn = userSignedIn;
      });
    }

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    User user = await _handleSignIn();


socialLogin(user.displayName,user.email,'123456',user.phoneNumber);
  }

  getSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _submitTask() async{
    try{



      final form = formKey.currentState;
      form.save();

      if(_mobile.length!=10){
  setState(() {
    Fluttertoast.showToast(
      msg:Constant.MOBILE_VALIDATION,
        toastLength: Toast.LENGTH_SHORT,
    //    gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      //  backgroundColor: Colors.red,
     //   textColor: Colors.white,
      //  fontSize: 16.0
    );
  });
}else/* if(_password.isEmpty){
  setState(() {
    Fluttertoast.showToast(
        msg:Constant.PASSWORD_VALIDATION,
        toastLength: Toast.LENGTH_SHORT,
       // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
     //   backgroundColor: Colors.red,
     //   textColor: Colors.white,
       // fontSize: 1.0
    );
  });

}else*/{

        try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.LOGIN_WITH_OTP);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
              "phone_number":_mobile.toString()
          };
          // make POST request
          Response response =
          await post(url, headers: headers, body: json.encode(map));
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
          CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);
          if (data["status"].toString() == "201") {

           String id =data['user']['user_id'].toString();

            prefs.setString(Constant.USR_OTP, data['user']['otp'].toString());
            prefs.setString(Constant.USER_MOBILE, data['user']['phone_number'].toString());
            prefs.setString(Constant.USER_ID, id);
            prefs.setString(Constant.USER_NAME, data['user']['first_name']);

            if(data['user']['email']!=null){
              prefs.setString(Constant.USER_EMAIL, data['user']['email']);
            }else{
              prefs.setString(Constant.USER_EMAIL, "");
            }

          /*  if(data['token']!=null){
              prefs.setString(Constant.USER_TOKEN, data['token']);
            }else{
              prefs.setString(Constant.USER_TOKEN, "");
            }*/

            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OtpVerify(type: 'login',)));

          } else {
            Fluttertoast.showToast(
              msg:Constant.SERVER_ISSUE,
              toastLength: Toast.LENGTH_SHORT,
              //    gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            //ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }
        //  print("body+++++" + body.toString());
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);
          CustomProgressLoader.cancelLoader(context);

        }

        }

    } catch (e) {
      print(e.toString());
    }
  }

  void socialLogin(name,_email,password,mobile) async{

           try {
          print("body+++++");
          CustomProgressLoader.showLoader(context);
          var url =Uri.parse(ApiConstant.SIGNUP_URL);
          Map<String, String> headers = {"Content-type": "application/json"};
          Map map = {
            "email":_email,
            "password":password,
            "phone_number":mobile,
            "first_name":name,
            "last_name":name,
            "user_type":"CUSTOMER"
          };
          // make POST request
          Response response =
          await post(url, headers: headers, body: json.encode(map));
          // check the status code for the result
          // this API passes back the id of the new item added to the body
          String body = response.body;
          CustomProgressLoader.cancelLoader(context);
          var data = json.decode(body);
          if (data["status"].toString() == "201") {
            String id =data['user']['id'].toString();

            prefs.setString(Constant.USR_OTP, data['user']['otp'].toString());
           // prefs.setString(Constant.USER_MOBILE, data['user']['phone_number']==null?"": data['user']['phone_number'].toString());
         //   prefs.setString(Constant.USER_NAME, data['user']['first_name']==null?"": data['user']['first_name'].toString());
         //   prefs.setString(Constant.USER_EMAIL, data['user']['email']==null?"": data['user']['email'].toString());
          //  prefs.setString(Constant.USER_TOKEN, data['token']);
            prefs.setString(Constant.USER_ID, id);

            if(data['user']['phone_number']!=null){
              prefs.setString(Constant.USER_MOBILE, data['user']['phone_number']);
            }else{
              prefs.setString(Constant.USER_MOBILE, "");
            }


            if(data['user']['first_name']!=null){
              prefs.setString(Constant.USER_NAME, data['user']['first_name']);
            }else{
              prefs.setString(Constant.USER_NAME, "");
            }


            if(data['token']!=null){
              prefs.setString(Constant.USER_TOKEN, data['token']);
            }else{
              prefs.setString(Constant.USER_TOKEN, "");
            }


            if(data['user']['email']!=null){
              prefs.setString(Constant.USER_EMAIL, data['user']['email']);
            }else{
              prefs.setString(Constant.USER_EMAIL, "");
            }


            Fluttertoast.showToast(
              msg:Constant.USER_REGISTER,
              toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        OtpVerify()));

          } else {
            Fluttertoast.showToast(
              msg:Constant.USER_ALREADY,
              toastLength: Toast.LENGTH_SHORT,
              // gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              //  backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //  fontSize: 16.0
            );
            //  ToastWrap.showSucess("User not registered", context);
            // ToastWrap.showSucess("Number Not Register. Please Sign Up", context);
          }
        } catch (e) {
          print("Error+++++" + e.toString());
          CustomProgressLoader.cancelLoader(context);

        }


  }


  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    return new WillPopScope(
       // onWillPop: _onWillPop,
        child:
    new Scaffold(
      backgroundColor: Color(0xff00F9FF),

        key: scaffoldKey,

      body:Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
      key: formKey,
      child:  SingleChildScrollView(
        child: Center(
          child: Container(
          //  color: Color(0xff00F9FF),
            child: Column(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
                  child: new Image.asset('image/toolbar_logo.png'),
                  width: 180.0,
              //    height: 80.0,
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  alignment: FractionalOffset(0.0, 0.5),
                  child: new Text(
                    "Let’s Get Started",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: ColorValues.TEXT_COLOR,
                      fontFamily: "customRegular",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 50.0, 0.0, 0.0),
                  alignment: FractionalOffset(0.0, 0.5),
                  child: new Text(
                    "Phone",
                    style: TextStyle(
                      fontSize: 13.0,
                      color: ColorValues.TEXT_COLOR,
                      fontFamily: "customLight",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                new Container(
                  height: 45.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),

                  ),
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child:new Center(
                      child: Container(

                        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        child: new TextFormField(
                          textAlign: TextAlign.start,

                          onSaved: (valueNumber) => _mobile = valueNumber,
                          maxLines: 1,
                          style: TextStyle(
                            color: ColorValues.TEXT_COLOR,
                            fontSize: 15.0,
                            fontFamily: "customLight",

                          ),
                          keyboardType: TextInputType.phone,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),

                          ],

                          decoration: InputDecoration(

                           // fillColor: Colors.white, filled: true,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: ColorValues.HINT_TEXT_COLOR,
                              fontSize: 15.0,
                              fontFamily: "customLight",
                            ),
                            hintText: "99999999999",
                            suffixIcon:    new Container(
                              padding: EdgeInsets.all(11.0),
                              child: new Image.asset('image/phone.png'),
                              width: 15.0,
                              height: 15.0,
                            ),
                          ),
                        ),
                        decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                    color: ColorValues.TEXT_COLOR,
                                    style: BorderStyle.none))),
                      )),
                ),
                mobileVisible?
                new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 0.0),
                  alignment: FractionalOffset(0.0, 0.5),
                  child: new Text(
                    Constant.BOTH_NU_EM_V,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: ColorValues.LOGOUT_TEXT,
                      fontFamily: "customLight",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ):new Center(),


                new Container(
                  height: 40,
                  margin: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
                  child: new Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(5.0),
                    color: ColorValues.TEXT_COLOR,
                    child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 2.0),
                        onPressed: () {
                          _submitTask();

                        },
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,fontSize: 15.0,
                            fontFamily: "customRegular",
                          ),
                        )),
                  ),
                ),
                 new Container(
                  margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: new Text("Or", style: TextStyle(
                    fontSize: 14.0,
                    color: ColorValues.TEXT_COLOR,
                    fontFamily: "customLight",
                  ),
                    textAlign: TextAlign.center,
                  ),
                ),

                new Container(
                  margin: EdgeInsets.fromLTRB(22.0, 5.0, 22.0, 0.0),
                  child:
                  new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  new Container(
                    //  height: 30,
                      width: 120.0,
                      padding: EdgeInsets.all(7.0),
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                  ),

                  child:
                      new InkWell(
                          onTap: (){
                            _login();
                          },
                          child:
                  new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        new Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                          child: new Image.asset('image/facebook.png'),
                          width: 30.0,
                              height: 20.0,
                        ),
                        new Container(
                          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                          child: new Text("Facebook", style: TextStyle(
                            fontSize: 12.0,
                            color: ColorValues.TEXT_COLOR,
                            fontFamily: "customRegular",
                          ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ])

                  ),
                  ),
                      new Container(
                        //  height: 30,
                         // width: MediaQuery.of(context).size.width,
                          width: 120.0,
                          padding: EdgeInsets.all(7.0),
                          decoration: new BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child:
                              InkWell(
                                  onTap: (){
                                    onGoogleSignIn(context);

                                  },
                                  child:
                          new Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                new Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
                                  child: new Image.asset('image/gmail.png'),
                                  width: 20.0,
                                  height: 20.0,
                                ),
                                new Container(
                                  margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                  child: new Text("Gmail", style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorValues.TEXT_COLOR,
                                    fontFamily: "customRegular",
                                  ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),


                              ])
                      ),
                      ),

                    ],
                  ),

                ),

                new GestureDetector(

                  child: new Container(
                    margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                    child: new Text("By Continuing, you agree to our Tearms of Service Privacy Policy Content Policy", style: TextStyle(
                        fontSize: 12.0,
                      color: ColorValues.TEXT_COLOR,
                      fontFamily: "customLight",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    )
    )
    )
    );
  }
}

class WelcomeUserWidget extends StatelessWidget {

  GoogleSignIn _googleSignIn;
  User _user;

  WelcomeUserWidget(User user, GoogleSignIn signIn) {
    _user = user;
    _googleSignIn = signIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(50),
            child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ClipOval(
                        child: Image.network(
                            _user.photoURL,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover
                        )
                    ),
                    SizedBox(height: 20),
                    Text('Welcome,', textAlign: TextAlign.center),
                    Text(_user.displayName, textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                    SizedBox(height: 20),
                    FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          _googleSignIn.signOut();
                          Navigator.pop(context, false);
                        },
                        color: Colors.redAccent,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.exit_to_app, color: Colors.white),
                                SizedBox(width: 10),
                                Text('Log out of Google', style: TextStyle(color: Colors.white))
                              ],
                            )
                        )
                    )
                  ],
                )
            )
        )
    );
  }
}