import 'dart:convert';

import 'package:chatgptapp/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';

class APIServices {
  List<ModelsModel> models = [];

  //Get API Key from Shared Preferences

  Future<String> myAPIKey() async {
    SharedPreferences apiPrefs = await SharedPreferences.getInstance();
    String myAPIKey = apiPrefs.getString('apiKey') ?? '';

    return myAPIKey;
  }

  //Get Models

  Future<List<ModelsModel>> getModels() async {
    String myAPIKey = await this.myAPIKey();
    
    var url = Uri.parse('https://api.openai.com/v1/models');

    var response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $myAPIKey'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load models');
    } else {
      var data = jsonDecode(response.body);
      for (var model in data['data']) {
        models.add(ModelsModel.fromJson(model));
      }
    }

    return models;
  }
}
