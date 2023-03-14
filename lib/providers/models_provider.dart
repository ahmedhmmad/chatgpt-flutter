import 'package:chatgptapp/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models_model.dart';

class ModelsProvider extends ChangeNotifier {
  List<ModelsModel> _models = [];
  List<ModelsModel> get models => _models;
  String currentModel = 'text-davinci-003';

  Future<String> getCurrentModel() async {
    final prefs = await SharedPreferences.getInstance();
    currentModel = prefs.getString('currentModel') ?? 'text-davinci-003';
    return currentModel;
  }

  void setCurrentModel(String currentModel) {
    this.currentModel = currentModel;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('currentModel', currentModel);
    });
    notifyListeners();
  }

  Future<List<ModelsModel>> getAllModels() async {
    _models = await APIServices().getModels();
    return _models;
  }
}
