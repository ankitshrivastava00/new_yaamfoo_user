class ApiConstant{
  //static final String BaseURL = "http://dev.yamfoo.com/api/v1";
  static final String BaseURL = "http://34.125.156.46:8000/api/v1";
 // static final String IMAGE_BASE_URL = "http://dev.yamfoo.com";
  static final String IMAGE_BASE_URL = "http://34.125.156.46:8000";

  static final String LOGIN_URL = BaseURL+"/user/api-login/";
  static final String SIGNUP_URL = BaseURL+"/user/api-signup/";
  static final String OTP_LOGIN = BaseURL+"/user/api-login-with-otp/";
  static final String LOGIN_WITH_OTP = BaseURL+"/user/login-with-otp/";
  static final String OTP_VERIFY = BaseURL+"/user/otp-verifiction/";
  static final String FORGOT_URL = BaseURL+"/user/api-forgot-password/";
  static final String PROFIL_URL = BaseURL+"/user/1/user-details/";
  static final String HOME_URL = BaseURL+"/restaurant/home-page/";
  static final String RESTURANT_SINGLE = BaseURL+"/restaurant/restaurant-page/?restaurant_id=";
  static final String FAVORITE_LIST = BaseURL+"/restaurant/favorite/?user=";
  static final String ADD_FAVORITE = BaseURL+"/restaurant/favorite/";
  static final String DELETE_FAVORITE = BaseURL+"/restaurant/favorite-details/?user=";
  static final String UPDATE_PROFILE = BaseURL+"/user/";
  static final String CHECK_OUT = BaseURL+"/restaurant/checkout/";
  static final String ADDRESS_BOOK = BaseURL+"/user/address/?user=";
  static final String ADD_ADDRESS = BaseURL+"/user/address/";
  static final String NOTIFICATION_LIST = BaseURL+"/administrator/push/notification/?user_type=CUSTOMER";
  static final String RESTAURENT_LIST = BaseURL+"/restaurant/get-all-restaurant/";
  static final String ORDER_DETAILS = BaseURL+"/restaurant/order/";
}