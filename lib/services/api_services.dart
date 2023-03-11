import 'dart:convert';

import 'package:chatgptapp/models/models_model.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';

class APIServices {
  List<ModelsModel> models = [];
  Future<List<ModelsModel>> getModels() async {
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
