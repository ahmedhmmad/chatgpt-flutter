import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  String apiKey = '';
  Future<String> getApiKey() async {
    SharedPreferences apiPrefs = await SharedPreferences.getInstance();
    apiKey = apiPrefs.getString('apiKey') ?? '';
    return apiKey;
  }

  Future<void> setApiKey(String apiKey) async {
    SharedPreferences apiPrefs = await SharedPreferences.getInstance();
    this.apiKey = apiKey;
    await apiPrefs.setString('apiKey', apiKey);
    //notifyListeners();
  }
}
