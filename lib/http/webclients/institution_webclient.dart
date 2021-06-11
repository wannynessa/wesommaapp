import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/institution.dart';

import '../webclient.dart';

class InstitutionWebClient {

  String urlInstitutions = baseUrl + 'api/institutions';
  String urlInstitution = baseUrl + 'api/institution';

  Future<List<Institution>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlInstitutions), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Institution.fromJson(json)).toList();
  }

  Future<Institution> save(Institution institution) async {
    String token = await generateToken();
    final String institutionJson = jsonEncode(institution.toJson());
    final Response response = await client.post(
        Uri.parse(urlInstitution),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: institutionJson
    );

    return Institution.fromJson(jsonDecode(response.body));
  }

  Future<Institution> update(Institution institution) async {
    String token = await generateToken();
    final String groupJson = jsonEncode(institution.toJson());
    final Response response = await client.put(
        Uri.parse(urlInstitution),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: groupJson
    );
    return Institution.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Institution institution) async {
    var id = institution.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlInstitution+'/$id'), headers: {'authorization' : token});
  }
 }