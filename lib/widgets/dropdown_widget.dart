import 'package:chatgptapp/models/models_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/models_provider.dart';

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key}) : super(key: key);

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  late Future<List<ModelsModel>> modelsList;
  String? currentModel;

  @override
  void initState() {
    super.initState();
    modelsList =
        Provider.of<ModelsProvider>(context, listen: false).getAllModels();
    Provider.of<ModelsProvider>(context, listen: false)
        .getCurrentModel()
        .then((value) {
      setState(() {
        currentModel = value;
      });
    });
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
                currentModel = value.toString();
              });
              Provider.of<ModelsProvider>(context, listen: false)
                  .setCurrentModel(currentModel!);
            },
            value: currentModel,
            // ignore: unnecessary_null_comparison
            hint: Provider.of<ModelsProvider>(context, listen: false)
                        .getCurrentModel ==
                    null
                ? const Text('Select Model')
                : Text(currentModel!),
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
