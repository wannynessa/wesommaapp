import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/cartao.dart';

import '../webclient.dart';

class CartaoWebClient {

  Future<List<Cartao>> findAll() async {
    final Response response =
    await client.get(Uri.parse(baseUrl)).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Cartao.fromJson(json)).toList();
  }

  Future<Cartao> save(Cartao cartao) async {

    final String cartaoJson = jsonEncode(cartao.toJson());

    final Response response = await client.post(
        Uri.parse(baseUrl),
        headers: {'Content-type': 'application/json', 'password': '1000'},
        body: cartaoJson
    );

    return Cartao.fromJson(jsonDecode(response.body));
  }
}