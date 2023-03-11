class ModelsModel {
  final String id;
  final int created;

  ModelsModel({
    required this.id,
    required this.created,
  });

  factory ModelsModel.fromJson(Map<String, dynamic> json) {
    return ModelsModel(
      id: json['id'],
      created: json['created'],
    );
  }

  // // return Model in a list
  // static List<ModelsModel> fromJsonList(List list) {
  //   print('List is $list');
  //   if (list.isEmpty) return [];
  //   List<ModelsModel> models =
  //       list.map((item) => ModelsModel.fromJson(item)).toList();
  //   print('Models is $models');
  //   return models;
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'id': id,
  //     'created': created,
  //     'model': model,
  //   };
  // }
}
