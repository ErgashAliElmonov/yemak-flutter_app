class CategoryModel {
  String title = '';
  int? id;

  CategoryModel({required this.title,required this.id});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      title: json['title'],
      id: json['id'],
    );
  }
}
