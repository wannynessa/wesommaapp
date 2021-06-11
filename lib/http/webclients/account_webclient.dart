import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';
import 'package:WeSOMMA/models/account.dart';

import '../webclient.dart';

class AccountWebClient {

  String urlGetAccounts = baseUrl +'api/accounts';
  String urlGetAccountsGroup = baseUrl +'api/accounts/group';
  String urlAccount = baseUrl + 'api/account';
  String urlAccountBalance = baseUrl + 'api/account/totalbalance';

  Future<List<Account>> findAll() async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGetAccounts), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Account.fromJson(json)).toList();
  }

  Future<List<Account>> findAllbyPerson(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGetAccounts + '/$id'), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Account.fromJson(json)).toList();
  }

  Future<List<Account>> findAllbyGroup(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlGetAccountsGroup + '/$id'), headers: {'authorization': token });
    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((dynamic json) => Account.fromJson(json)).toList();
  }

  Future<double> findTotalAccountBalance(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlAccountBalance + '/$id'), headers: {'authorization': token });
    return double.parse(response.body);
  }

  Future<Account> findId(var id) async {
    String token = await generateToken();
    final Response response = await client.get(Uri.parse(urlAccount + '/$id'), headers: {'authorization': token});
    return Account.fromJson(jsonDecode(response.body));
  }

  Future<Account> save(Account account) async {
    String token = await generateToken();

    final String accountJson = jsonEncode(account.toJson());

    final Response response = await client.post(
        Uri.parse(urlAccount),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: accountJson
    );

    return Account.fromJson(jsonDecode(response.body));
  }

  Future<Account> update(Account account) async {
    String token = await generateToken();

    final String personJson = jsonEncode(account.toJson());

    final Response response = await client.put(
        Uri.parse(urlAccount),
        headers: {'Content-type': 'application/json',
          'Accept': 'application/json','authorization' : token},
        body: personJson
    );

    return Account.fromJson(jsonDecode(response.body));
  }

  Future<void> delete(Account account) async {
    var id = account.id;
    String token = await generateToken();
    final Response response = await client.delete(Uri.parse(urlAccount+'/$id'), headers: {'authorization' : token});
  }
}

class TotalAccount {
  double total;

  TotalAccount({this.total});

  factory TotalAccount.fromJson(Map<String, dynamic> json) {
    return TotalAccount(
        total: json["total"] as double,
    );
  }
}