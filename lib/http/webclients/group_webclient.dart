import 'dart:convert';

import 'package:WeSOMMA/models/person.dart';
import 'package:http/http.dart';
import 'package:WeSOMMA/models/group.dart';

import '../webclient.dart';

class GroupWebClient {
  String urlGroups = baseUrl + 'api/groups';
  String urlGroup = baseUrl + 'api/group';

  Future<List<Group>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlGroups), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Group.fromJson(json)).toList();
  }

  Future<List<Group>> findAllByPerson(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGroups + '/$id'), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Group.fromJson(json)).toList();
  }

  Future<Group> save(Group group) async {
    String token = await generateToken();

    final String grupoJson = jsonEncode(group.toJson());

    final Response response = await client.post(
        Uri.parse(urlGroup),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: grupoJson
    );

    return Group.fromJson(jsonDecode(response.body));
  }

  Future<Group> update(Group group) async {
    String token = await generateToken();
    for(int i = 1; i < group.people.length; i++) {
      group.people.removeAt(i);
    }
    group.leader.group = null;
    final String groupJson = jsonEncode(group.toJson());
    final Response response = await client.put(
        Uri.parse(urlGroup),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: groupJson
    );
    return Group.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Group group) async {
    var id = group.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlGroup+'/$id'), headers: {'authorization' : token});
  }
}