import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/person.dart';
import 'package:WeSOMMA/models/user.dart';

import '../webclient.dart';

class LoginWebClient {

  String urlLogin = baseUrl + 'api/login';

  Future<Person> login(User user) async {
    String token = await generateToken();

    final String userJson = jsonEncode(user.toJson());

    final Response response = await client.post(
        Uri.parse(urlLogin),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: userJson
    );

    if(response.body != null && response.body.isNotEmpty) {
      return Person.fromJson(jsonDecode(response.body));
    }
    return null;
  }
}