import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:yaamfoo/values/ColorValues.dart';

class Constant {
  static bool V_CONTROL = true; // If true then Feature will

  // static const String BASE_URL = "http://ziasytechnology.ca/merrytea/e-commerce/index.php/appController/";
  // static const String BASE_URL = "http://desithekanews.com/287merrytea/index.php/appController/";
  // static const String CONSTANT_IMAGE_PATH = "http://desithekanews.com/287merrytea/assets/uploads/";
 // static const String CONSTANT_IMAGE_PATH = "http://ziasytechnology.ca/merrytea/e-commerce/assets/uploads/";
  static const String CONSTANT_IMAGE_PATH = "http://287merryteasagar.in/assets/uploads/";
  static const String BASE_URL = "https://287merryteasagar.in/index.php/appController/";
  static const String PRODUCT_LIST = "productlist";
  static const String SLIDER_LIST = "sliderimages";
  static const String BANNER_LIST = "banner";
  static const String SIGNUP = "signup";
  static const String SIGNIN = "signin";
  static const String SEND_OTP = "sendotp";
  static const String SEND_OTP_LOGIN = "sendloginotp";
  static const String ADD_ADDRESS = "addclientAddress";
  static const String UPDATE_ADDRESS = "updateclientAddress";
  static const String CLIENT_ADDRESS = "clientAddress";
  static const String CLIENT_CART_DATA_LIST= "addtocart";
  static const String CLIENT_CART_DATA= "addsinglecart";
  static const String CLIENT_CART_DATA_COUNT= "cartcount";
  static const String CLIENT_CART_REMOVE= "removecartproduct";
  static const String CART_DETAIL = "cartlist";
  static const String ORDER_DETAIL = "orderlist";
  static const String ORDER_SINGLE_DETAIL = "orderdetailslist";
  static const String SEARCH_PRODUCT = "searchproduct";
  static const String CONTACT_US = "contactus";
  static const String SUBMIT_ORDER = "submitorder";
  static const String CANCEL_ORDER = "cancelorder";
  static const String Review = "productRating";
  static const String SubmitReview = "submitRating";
  static const String WhatWeDo = "whatwedo";
  static const String promocode = "promocode";
  static const String checkpromo = "applypromocode";
  static const String notification = "notificationlist";
  static const String notificationOffOn = "clientnotify";

  static const String deleteaddress = "removeclientAddress";
  static const String deliveryCharges = "dcharge";
  static const String setting = "settings";

  static const int SERVICE_TIME_OUT = 30000;
  static const int CONNECTION_TIME_OUT = 30000;
  static bool IS_INDIVIDUAL = true;
  static BuildContext applicationContext;
  static String pageNameFr;
  static bool isAlreadyLoggedIn = false;
  static bool isBackVisible = false;
  static int currentIndex = 0;
  static String customRegular = "customRegular";
  static String customItalic = "customItalic";
  static String customBold = "customBold";
  static String REQUESTED = "2";
  static String ACCEPTED = "3";
  static String INVITED = "4";
  static String NON_CONNECTION = "1";
  static String SENT_REQUEST = "5";
  static String PEOPLE_YOU_MAY_KNOW = "6";
  static String PENDING = "7";
  static String RECIEVED = "8";
  static String LINK_URL = "1";
  static String JOIN_GROUP = "2";
  static String CALL_NOW = "3";
  static String INQUIRE_NOW = "4";
  static String LEARN_MORE = "1";
  static String GET_OFFER = "2";
  static String APPLY_NOW = "3";
  static String CONST_REQUESTED = "Requested";
  static String CONST_REPLIED = "Replied";
  static String CONST_PENDING = "Pending";
  static String GROUP_TYPE_PUBLIC = "public";
  static String GROUP_TYPE_PRIVATE = "private";
  static Color CURSOR_COLOR = new Color(ColorValues.HEADING_COLOR_EDUCATION);

  // Session Key
  static String LOGIN_STATUS = "loginstatus";
  static String USER_ID = "userId";
  static String USER_EMAIL = "userEmail";
  static String USER_MOBILE = "userMobile";
  static String USR_OTP = "userOtp";
  static String USER_NAME = "userName";
  static String USER_TOKEN = "userToken";
  static String USER_FCM = "userFcm";


  // Component Data
  static final String EMAIL_HINT = "Email *";
  static final String FIRST_NAME_HINT = "First Name *";
  static final String LAST_NAME_HINT = "Last Name *";
  static final String PASSWORD_HINT = "Password *";
  static final String CONFIRM_PASSWORD_HINT = "Confirm Password *";
  static final String MOBILE_HINT = "Mobile *";
  static final String ADDRESS1_HINT = "Address 1 *";
  static final String ADDRESS2_HINT = "Address 2 *";
  static final String CITY_HINT = "City *";
  static final String STATE_HINT = "State *";
  static final String COUNTRY_HINT = "Country *";
  static final String PINCODE_HINT = "Pincode *";
  static final String INSTITUTE_HINT = "Institute *";
  static final String CLASS_HINT = "Class *";
  static final String REGISTER_BUTTON_HINT = "REGISTER";
  static final String LOGIN_BUTTON = "LOGIN";
  static final String REGISTRATION_PAGE = "Registration";
  static final String NOTIFICATION_HINT = "Notification";
  static final String LOGIN_PAGE = "Login";
  static final String LOGOUT_BUTTON = "Logout";
  static final String NOTIFIC_BUTTON = "Logout";

  // VALIDATION HINT
  static final String BOTH_NU_EM_V = "Enter Your Email/Phone";
  static final String FIRST_NAME_VALIDATION = "Enter Your Name ";
  static final String LAST_NAME_VALIDATION = "Enter Your Last Name ";
  static final String EMAIL_VALIDATION = "Not a Valid Email ";
  static final String PASSWORD_VALIDATION = "Password Too Short ";
  static final String CONFIRM_PASSWORD_VALIDATION = "Password Not Matched ";
  static final String MOBILE_VALIDATION = "Enter Correct Number";
  static final String ADDRESS1_VALIDATION = "Enter Delivery Address";
  static final String ADDRESS2_VALIDATION = "Enter Address2";
  static final String CITY_VALIDATION = "Select City";
  static final String STATE_VALIDATION = "Select State";
  static final String COUNTRY_VALIDATION = "Select Country";
  static final String CLASS_VALIDATION = "Select Class";
  static final String INSTITUTE_VALIDATION = "Select Institute";
  static final String PINCODE_VALIDATION = "Enter Correct Pincode";
  static final String OTP_VALIDATION = "Enter Correct Pincode";

  // TOAST MESSAGES
  static final String USER_ALREADY = "Please use Diffrent Mobile ,User already registered";
  static final String USER_REGISTER = "User registered";
  static final String ADD_SUCCESFULLY = "Added Succesfully";
  static final String NOTIFICATION_SEND = "Send Succesfully";
  static final String UPDATE_PROFILE = "Your Profile Added Succesfully";
  static final String DELETE_FAVORITE = "UNLIKE Succesfully";
  static final String ADD_FAVORITE = "Added Succesfully";
  static final String ALREADY_FAVORITE = "Already Added";
  static final String INCORRECT_PASSWORD = "Incorrect Email And Password";
  static final String SERVER_ISSUE = "Something Went Wrong";
  static final String INVALID_OTP = "Invalid OTP";
  static final String INCORRECT_NUMBER = "Invalid Number";
  static final String ADD_TO_CART = "Added Succesfully";

}
