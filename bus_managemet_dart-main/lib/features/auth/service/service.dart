import 'dart:convert';
import 'package:bus_management/constants/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Service {
  final String baseUrl = 'http://10.0.2.2:5500/api';

  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> register(String firstName, String lastName,
      String phoneNum, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'firstName': firstName,
          'lastName': lastName,
          'phoneNum': phoneNum,
          'email': email,
          'password': password,
        }));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode({'email': email, 'password': password}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = json.decode(response.body);

      await storage.write(key: 'token', value: responseData['token']);
      await storage.write(
          key: 'userData', value: jsonEncode(responseData['userData']));
      final token = await storage.read(key: 'token');
      final userData = await storage.read(key: 'userData');
      print('Token: $token');
      print('User Data: $userData');
      return responseData;
    } else {
      throw Exception(json.decode(response.body)['message']);
    }
  }

  Future<Map<String, dynamic>> getProfile(BuildContext context) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      showSnackBar(
          message: 'Token Missing', context: context, color: Colors.red);
      return {};
    }

    final decodedToken = JwtDecoder.decode(token);
    final userId = decodedToken['id'];
    if (userId == null) {
      showSnackBar(
          message: 'ID Not Found', context: context, color: Colors.red);
      return {};
    }

    final response = await http.get(Uri.parse('$baseUrl/profile/$userId'));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']);
    }
  }
}
