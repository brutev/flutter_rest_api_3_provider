import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3_provider/Provider/database_provider.dart';
import 'package:flutter_rest_api_3_provider/constants/url.dart';
import 'package:flutter_rest_api_3_provider/screens/home_screen.dart';
import 'package:flutter_rest_api_3_provider/utility/routes.dart';
import 'package:http/http.dart' as http;

class DeleteTaskProvider extends ChangeNotifier {
  final url = AppUrl.baseUrl;

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  ///To get graphql client
  ///Add task method
  void deleteTask({String? taskId, BuildContext? ctx}) async {
    final token = await DatabaseProvider().getToken();
    _status = true;
    notifyListeners();

    final _url = "$url/tasks/$taskId";

    final result = await http
        .delete(Uri.parse(_url), headers: {'Authorization': "Bearer $token"});

    print(result.statusCode);

    if (result.statusCode == 200 || result.statusCode == 201) {
      final res = result.body;
      print(res);
      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
      PageNavigator(ctx: ctx).nextPageOnly(page: const HomePage());
    } else {
      final res = result.body;
      print(res);
      _status = false;

      _response = json.decode(res)['message'];

      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
