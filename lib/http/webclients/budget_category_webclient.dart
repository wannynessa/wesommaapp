import 'dart:convert';

import 'package:WeSOMMA/models/budget_category.dart';
import 'package:http/http.dart';
import 'package:WeSOMMA/models/budget.dart';

import '../webclient.dart';

class BudgetCategoryWebClient {
  String urlBudgetCategories = baseUrl + 'api/budgetCategories';
  String urlBudgetCategory = baseUrl + 'api/budgetCategory';

  Future<List<BudgetCategory>> findAllByBudget(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlBudgetCategories + '/$id'), headers: {'authorization': token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => BudgetCategory.fromJson(json)).toList();
  }

  Future<BudgetCategory> save(BudgetCategory budgetCategory) async {
    String token = await generateToken();

    final String budgetJson = jsonEncode(budgetCategory.toJson());

    final Response response = await client.post(
        Uri.parse(urlBudgetCategory),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: budgetJson
    );

    return BudgetCategory.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(BudgetCategory budgetCategory) async {
    var id = budgetCategory.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlBudgetCategory+'/$id'), headers: {'authorization' : token});
  }
}