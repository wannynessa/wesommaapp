import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/budget.dart';

import '../webclient.dart';

class BudgetWebClient {
  String urlBudgets = baseUrl + 'api/budgets';
  String urlBudgetsGroup = baseUrl + 'api/budgets/group';
  String urlBudget = baseUrl + 'api/budget';

  Future<List<Budget>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlBudgets), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Budget.fromJson(json)).toList();
  }

  Future<List<Budget>> findAllOpenByPerson(var isOpen, var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlBudgets + '/$isOpen' + '/$id'), headers: {'authorization': token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Budget.fromJson(json)).toList();
  }

  Future<List<Budget>> findAllOpenByGroup(var isOpen, var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlBudgetsGroup + '/$isOpen' + '/$id'), headers: {'authorization': token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Budget.fromJson(json)).toList();
  }

  Future<List<Budget>> findAllByPerson(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlBudget + '/$id'), headers: {'authorization': token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Budget.fromJson(json)).toList();
  }

  Future<List<Budget>> findAllByGroup(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlBudgetsGroup + '/$id'), headers: {'authorization': token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Budget.fromJson(json)).toList();
  }

  Future<Budget> save(Budget budget) async {
    String token = await generateToken();

    final String budgetJson = jsonEncode(budget.toJson());

    final Response response = await client.post(
        Uri.parse(urlBudget),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: budgetJson
    );

    return Budget.fromJson(jsonDecode(response.body));
  }

  Future<Budget> update(Budget budget) async {
    String token = await generateToken();
    final String budgetJson = jsonEncode(budget.toJson());
    final Response response = await client.put(
        Uri.parse(urlBudget),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: budgetJson
    );
    return Budget.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Budget budget) async {
    var id = budget.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlBudget+'/$id'), headers: {'authorization' : token});
  }
}