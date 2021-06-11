import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/patrimonio.dart';

import '../webclient.dart';

class PatrimonioWebClient {

  Future<List<Patrimonio>> findAll() async {
    final Response response =
    await client.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Patrimonio.fromJson(json)).toList();
  }

  Future<Patrimonio> save(Patrimonio patrimonio) async {

    final String patrimonioJson = jsonEncode(patrimonio.toJson());

    final Response response = await client.post(
        Uri.parse(baseUrl),
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: patrimonioJson
    );

    return Patrimonio.fromJson(jsonDecode(response.body));
  }
}