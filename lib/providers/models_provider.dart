import 'package:flutter/material.dart';

import '../models/models_model.dart';

class ModelsProvider extends ChangeNotifier {
  final List<ModelsModel> _models = [];
  List<ModelsModel> get models => _models;
  String currentModel = 'text-davinci-003';
  String get getCurrentModel => currentModel;

  void setCurrentModel(String currentModel) {
    this.currentModel = currentModel;
    notifyListeners();
  }
}
