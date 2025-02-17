class APIURL {
  static const String ip = "192.168.1.67";
  static const String apiKey = "AIzaSyCX_tA47PuLrlO5Qa7_ADV0sllc98_K3d8";
  static const String localhost = "https://sunofamap.com/api/v1";
  // static const String localhost = "http://192.168.1.67:8000/api/v1";
  // static const String localhost = "https://d297-102-64-220-111.ngrok-free.app/api/v1";
  static const String users = "$localhost/users";
  static const String login = "$localhost/login";
  static const String logout = "$localhost/logout";
  
  static const String adresseBook = "$localhost/address-books";
  // static const String getAdresseBook = "$localhost/address-books/et";
  static const String adresses = "$localhost/addresses";
  static const String searchAdresses = "$localhost/addresses/search";
  static const String favories = "$localhost/favories";
  static const String notes = "$localhost/notes";
  static const String notifications = "$localhost/notifications";
  // static const String couponsURL = "$localhost/coupons";
  // static const String betssURL = "$localhost/bets";
  // static const String otpsURL = "$localhost/otp";
  static const String transactionsURL = "$localhost/transactions";
  static const String forgotpassURL = "$localhost/forgotpass";

  // fgp
  static const String verifyEmailCode = "$forgotpassURL/verify-code";
}
