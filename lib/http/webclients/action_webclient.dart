import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/acoes.dart';

import '../webclient.dart';

class ActionWebClient {
  String urlGetActions = baseUrl + 'api/actions';
  String urlAction = baseUrl + 'api/action';

  Future<List<Action>> findAll() async {
    String token = await generateToken();

    final Response response =
    await client.get(Uri.parse(urlGetActions), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Action.fromJson(json)).toList();
  }

  Future<Action> save(Action action) async {
    String token = await generateToken();

    final String actionJson = jsonEncode(action.toJson());

    final Response response = await client.post(
        Uri.parse(urlAction),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: actionJson
    );

    return Action.fromJson(jsonDecode(response.body));
  }



  Future<Action> update(Action acton) async {
    String token = await generateToken();

    final String actionJson = jsonEncode(acton.toJson());

    final Response response = await client.put(
        Uri.parse(urlAction),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: actionJson
    );

    return Action.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Action action) async {
    var id = action.id;
    String token = await generateToken();

    final Response response = await client.delete(
        Uri.parse(urlAction+'/$id'),
        headers: {'authorization' : token})
    ;

  }
}