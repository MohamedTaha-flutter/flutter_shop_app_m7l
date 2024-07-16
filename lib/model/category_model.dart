class CategoryModel {
  final bool status;

  final CategoryDataModel data;

  CategoryModel({required this.status, required this.data});

  factory CategoryModel.fromJson(json) {
    return CategoryModel(
      status: json['status'],
      data: CategoryDataModel.fromJson(json['data']),
    );
  }
}

class CategoryDataModel {
  int? current_page;

  final List<DataModel> data = [];

  CategoryDataModel.fromJson(json) {
    current_page = json["current_page"];

    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  final int id;

  final dynamic name;

  final dynamic image;

  DataModel({required this.id, required this.name, required this.image});

  factory DataModel.fromJson(json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
