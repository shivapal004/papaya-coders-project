import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService{

  final String loginApi = "https://ventex.papayacoders.com/ventexapi/v1/login";
  final String getDataApi = "https://ventex.papayacoders.com/ventexapi/v1/login/routine";

  Future<String?> login(String email, String password) async{
    final response = await post(
      Uri.parse(loginApi),
      body: {
        "Email" : email,
        "Password" : password
      }
    );

    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['token'];
    }
    else{
      log("Login Failed");
      return null;
    }
  }


  Future<Map<String, dynamic>?> getData(String token) async {
    final response = await http.get(
      Uri.parse(getDataApi),
      headers: {
        "Authorization" : "Bearer $token"
      }
    );

    if(response.statusCode == 200){
      return json.decode(response.body);
    }else{
      log("Failed to fetch data");
      return null;
    }
  }


}