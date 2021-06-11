import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/goal.dart';

import '../webclient.dart';

class GoalWebClient {
  String urlGoals = baseUrl + 'api/goals';
  String urlGoal = baseUrl + 'api/goal';
  String urlGoalsGroup = baseUrl + 'api/goals/group';


  Future<List<Goal>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlGoals), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Goal.fromJson(json)).toList();
  }

  Future<List<Goal>> findAllbyPerson(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGoals + '/$id'), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Goal.fromJson(json)).toList();
  }

  Future<List<Goal>> findAllbyGroup(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGoalsGroup + '/$id'), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Goal.fromJson(json)).toList();
  }

  Future<Goal> save(Goal goal) async {
    String token = await generateToken();
    final String goalJson = jsonEncode(goal.toJson());
    final Response response = await client.post(
        Uri.parse(urlGoal),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: goalJson
    );
    return Goal.fromJson(jsonDecode(response.body));
  }

  Future<Goal> update(Goal goal) async {
    String token = await generateToken();
    final String goalJson = jsonEncode(goal.toJson());
    final Response response = await client.put(
        Uri.parse(urlGoal),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: goalJson
    );
    return Goal.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Goal goal) async {
    var id = goal.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlGoal+'/$id'), headers: {'authorization' : token});
  }
}