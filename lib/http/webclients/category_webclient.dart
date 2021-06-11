import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/category.dart';

import '../webclient.dart';

class CategoryWebClient {

  String urlGroups = baseUrl + 'api/categories';
  String urlGroup = baseUrl + 'api/category';

  Future<List<Category>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlGroups), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Category.fromJson(json)).toList();
  }

  Future<List<Category>> findAllByType(String type) async {
    if(type == null) {
      type = "Entrada";
    }
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlGroups + "/$type"), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Category.fromJson(json)).toList();
  }

  Future<Category> save(Category category) async {
    String token = await generateToken();
    final String categoryJson = jsonEncode(category.toJson());
    final Response response = await client.post(
        Uri.parse(urlGroup),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: categoryJson
    );
    return Category.fromJson(jsonDecode(response.body));
  }

  Future<Category> update(Category category) async {
    String token = await generateToken();
    final String categoryJson = jsonEncode(category.toJson());
    final Response response = await client.put(
        Uri.parse(urlGroup),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: categoryJson
    );
    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Category category) async {
    var id = category.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlGroup+'/$id'), headers: {'authorization' : token});
  }
}