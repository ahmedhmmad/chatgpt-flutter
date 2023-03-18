import 'dart:convert';

import 'package:chatgptapp/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../models/chat_model.dart';

class APIServices {
  List<ModelsModel> models = [];
  List<ChatModel> chatModel = [];

  //Get API Key from Shared Preferences

  Future<String> myAPIKey() async {
    SharedPreferences apiPrefs = await SharedPreferences.getInstance();
    String myAPIKey = apiPrefs.getString('apiKey') ?? '';

    return myAPIKey;
  }

  //Get Models

  Future<List<ModelsModel>> getModels() async {
    String myAPIKey = await this.myAPIKey();

    var url = Uri.parse('$baseUrl/models');

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

  Future<List<ChatModel>> getChatResponse(
      String message, String modelId) async {
    String myAPIKey = await this.myAPIKey();

    var url = Uri.parse('$baseUrl/completions');

    var response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $myAPIKey',
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          "model": modelId,
          "prompt": message,
          "max_tokens": 100,
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load models');
    }
    var data = jsonDecode(response.body);

    for (var msg in data['choices']) {
      chatModel.add(ChatModel.fromJson(msg));
    }

    return chatModel;
  }
}
