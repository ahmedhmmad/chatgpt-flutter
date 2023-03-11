import 'package:chatgptapp/models/models_model.dart';
import 'package:flutter/material.dart';
import 'package:chatgptapp/services/api_services.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late String _currentModel = 'text-davinci-003';

  APIServices apiServices = APIServices();

  late Future<List<ModelsModel>> modelsList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    modelsList = apiServices.getModels();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: modelsList,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return DropdownButton<String>(
            items: snapshot.data!
                .map<DropdownMenuItem<String>>((value) =>
                    DropdownMenuItem<String>(
                      value: value.id,
                      child:
                          Text(value.id, style: const TextStyle(fontSize: 12)),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _currentModel = value.toString();
              });
              // setState(() {
              //   _currentModel = value!;
              // });
              print(value.toString());
            },
            value: _currentModel,
            hint: _currentModel == null
                ? const Text('Select Model')
                : Text(_currentModel),
          );
        } else if (snapshot.hasError) {
          return const Text('No data found');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
