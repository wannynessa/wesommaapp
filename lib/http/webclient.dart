import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/logging_interceptor.dart';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
);

Future<Response> getToken() async {
  String username = 'wesomma';
  String password = 'wARu9Y2Da+x8L@+A';
  String basicAuth = 'Basic '+ base64Encode(utf8.encode('$username:$password'));
  final Response responseToken = await client.post(
      Uri.http("200.19.107.179:8080", "oauth/token"),
    headers: {
      'Authorization' : basicAuth
    },
    body: {
      'grant_type': 'password',
      'username': 'app',
      'password': '@UebqSxY=9pC3nHH'
    },
  );
  return responseToken;
}

Future<String> generateToken() async {
  Response responseToken = await getToken();

  final decodedJsonToken = jsonDecode(responseToken.body);
  String token = 'Bearer '+ decodedJsonToken['access_token'];
  return token;
}

const String baseUrl = 'http://200.19.107.179:8080/';
const String baseUrlToken = 'http://200.19.107.179:8080/oauth/token';
//const String baseUrl = 'http://192.168.0.10:8080/';
//const String baseUrlToken = 'http://192.168.0.10:8080/oauth/token';

