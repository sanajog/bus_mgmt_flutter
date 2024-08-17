class ApiEndpoints {
  //Connection Timeout
  static const Duration connectionTimeout = Duration(seconds: 100);
  //Recieve Timeout
  static const Duration recieveTimeout = Duration(seconds: 100);

  //For Windows Base URL
  static const String baseUrl = 'http://10.0.2.2:5500/api/';
  // For MAC
  // static const String baseUrl = "http://localhost:5500/api/";

  static const String register = "/signup";
}
