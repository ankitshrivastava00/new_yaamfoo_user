import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:yaamfoo/values/ColorValues.dart';

import 'SignUp.dart';
import 'login.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/dot_animation_enum.dart';
class StartScreen extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  StartScreenState createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  int _counter = 0;
  List<Slide> slides = [];

  Function goToTab;
  @override
  void initState() {
    super.initState();

    slides.add(
  new Slide(
  title: "Lorem Ipsume",
  styleTitle: TextStyle(
  color: ColorValues.TEXT_COLOR,
  fontSize: 15.0,
    fontFamily: "customSemiBold",

  ),
  description:
  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa.",
  styleDescription: TextStyle(
      color: ColorValues.TEXT_COLOR,
  fontSize: 15.0,
    fontFamily: "customLight",
  ),
  pathImage: "image/slider1.png",
  ),
  );
  slides.add(
  new Slide(
  title: "MUSEUM",
  styleTitle: TextStyle(
      color: ColorValues.TEXT_COLOR,
      fontSize: 15.0,
    fontFamily: "customSemiBold",

  ),
  description:
  "Ye indulgence unreserved connection alteration appearance",
  styleDescription: TextStyle(
      color: ColorValues.TEXT_COLOR,
      fontSize: 15.0,
    fontFamily: "customLight",

  ),
  pathImage: "image/slider2.png",
  ),
  );
}

void onDonePress() {
  // Back to the first tab
  this.goToTab(0);
}

void onTabChangeCompleted(index) {
  // Index of current tab is focused
}

Widget renderNextBtn() {
  return Icon(
    Icons.navigate_next,
    color: Color(0xffffcc5c),
    size: 35.0,
  );
}

Widget renderDoneBtn() {
  return Icon(
    Icons.done,
    color: Color(0xffffcc5c),
  );
}

Widget renderSkipBtn() {
  return Icon(
    Icons.skip_next,
    color: Color(0xffffcc5c),
  );
}

List<Widget> renderListCustomTabs() {
  List<Widget> tabs = [];
  for (int i = 0; i < slides.length; i++) {
    Slide currentSlide = slides[i];
    tabs.add(Container(
      width: double.infinity,
      height: double.infinity,
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0, top: 30.0),
        child: ListView(
          children: <Widget>[

          /* Row(
            children: [
              Text('SKIP'),
              Image.asset('image/skip.png'),
            ],
          ),*/
            Container(
              child: Text(
                currentSlide.title,
                style: currentSlide.styleTitle,
                textAlign: TextAlign.start,
              ),
              margin: EdgeInsets.fromLTRB( 30.0,15.0,30.0,20.0),
            ),
            Container(
              child: Text(
                currentSlide.description,
                style: currentSlide.styleDescription,
                textAlign: TextAlign.start,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              margin: EdgeInsets.fromLTRB( 30.0,15.0,30.0,20.0),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
                child: Image.asset(
                  currentSlide.pathImage,
                  width: 150.0,
                  height: 150.0,
                  // fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    ));
  }
  return tabs;
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
backgroundColor: Colors.white,
            body:new Container(
             // color: Colors.yellowAccent,
              child: new Container(
                child: new Column(
                  children: [
                    new Expanded(
                      child: new Container(
                        child:    new IntroSlider(


                          // Dot indicator
                          colorDot: ColorValues.TEXT_COLOR,
                          sizeDot: 10.0,
                          typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

                          // Tabs
                          listCustomTabs: this.renderListCustomTabs(),
                          backgroundColorAllSlides: ColorValues.SLIDER_BACKGROUND_COLOR,
                          refFuncGoToTab: (refFunc) {
                            this.goToTab = refFunc;
                          },

                          // Behavior
                          scrollPhysics: BouncingScrollPhysics(),

                          // Show or hide status bar
                          hideStatusBar: false,
                          showDoneBtn: false,
                          colorDoneBtn: ColorValues.SLIDER_BACKGROUND_COLOR,
                          showNextBtn: false,
                          showPrevBtn: false,
                          showSkipBtn: false,
                          namePrevBtn: '',

                          // On tab change completed
                       //   onTabChangeCompleted: this.onTabChangeCompleted,

                        )
,
                        color: Colors.grey,
                      ),
                      flex: 8,

                    ),

                    new Expanded(
                      child: new Container(

                        child:
                        new Column(
                          children: [

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
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  Login()));
                                    },
                                    child: Text(
                                      "Sign In",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,fontSize: 15.0,
                                          fontFamily: "customRegular",

                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ),
/*
                            new Container(
                              margin: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                              child:
                              new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  new Container(


                                    child:
                                    new Text(
                                      "Don’t Have An Account? ",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: ColorValues.TEXT_COLOR,

                                        fontFamily: "customLight",

                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),

                                  new GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) => SignUp()));
                                    },
                                    child:  new Text(
                                      " Sign Up",
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: ColorValues.TEXT_COLOR,
                                          fontFamily: "customLight",
                                          fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.left,

                                    ),
                                  ),

                                ],
                              ),

                            ),
*/

                          ],

                        ),
                        color: Colors.white,
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),

    );
  }
}