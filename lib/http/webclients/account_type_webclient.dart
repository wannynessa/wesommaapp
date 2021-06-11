import 'dart:convert';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/account_type.dart';

import '../webclient.dart';

class AccountTypeWebClient {
  String urlGroups = baseUrl + 'api/accounttypes';
  String urlAccountType = baseUrl + 'api/accounttype';

  Future<List<AccountType>> findAll() async {
    String token = await generateToken();
    Response response = await client.get(Uri.parse(urlGroups), headers: {'authorization' : token});
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => AccountType.fromJson(json)).toList();
  }

  Future<AccountType> save(AccountType accountType) async {
    String token = await generateToken();

    final String accountTypeJson = jsonEncode(accountType.toJson());

    final Response response = await client.post(
        Uri.parse(urlAccountType),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: accountTypeJson
    );

    return AccountType.fromJson(jsonDecode(response.body));
  }

  Future<AccountType> update(AccountType accountType) async {
    String token = await generateToken();
    final String accountTypeJson = jsonEncode(accountType.toJson());
    final Response response = await client.put(
        Uri.parse(urlAccountType),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: accountTypeJson
    );
    return AccountType.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(AccountType accountType) async {
    var id = accountType.id;
    String token = await generateToken();
    await client.delete(Uri.parse(urlAccountType+'/$id'), headers: {'authorization' : token});
  }
}