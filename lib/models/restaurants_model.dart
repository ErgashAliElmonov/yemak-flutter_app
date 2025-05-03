class RestaurantsModel {
  int? id;
  String? name;
  String? description;
  String? logotype;
  String? image;
  // bool? isActive;

  RestaurantsModel({
    this.id,
    this.name,
    this.description,
    this.logotype,
    this.image,
    // this.isActive,
  });

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) {
    // isActive = json['isActive'];

    return RestaurantsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      logotype: json['logotype'],
      image: json['image'],
    );
  }
}
