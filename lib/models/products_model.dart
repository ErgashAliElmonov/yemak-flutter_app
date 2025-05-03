class ProductsModel {
  final List products;

  ProductsModel({required this.products});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      products:
          json['products'].map((item) => Category.fromJson(item)).toList(),
    );
  }
}

class Category {
  final int id;
  final String title;
  final List<Product> products;

  Category({required this.id, required this.title, required this.products});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      products:
          (json['products'] as List)
              .map((item) => Product.fromJson(item))
              .toList(),
    );
  }
}

class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? photo;
  final List<Option>? options;
  final bool isAvailable;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photo,
    required this.isAvailable,
    this.options,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      photo: json['image'] ?? "",
      isAvailable: json['is_available'],
      options:
          json['options'] != null
              ? (json['options'] as List)
                  .map((item) => Option.fromJson(item))
                  .toList()
              : null,
    );
  }
}

class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String? photo;
  final List<Option>? options;
  final bool isAvailable;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.photo,
    required this.isAvailable,
    this.options,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      photo: json['photo'] ?? "",
      isAvailable: json['is_available'],
      options:
          json['options'] != null
              ? (json['options'] as List)
                  .map((item) => Option.fromJson(item))
                  .toList()
              : null,
    );
  }
}

class Option {
  final int id;
  final String name;
  final List<RowOption> rows;

  Option({required this.id, required this.name, required this.rows});

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'],
      name: json['name'],
      rows:
          (json['rows'] as List)
              .map((item) => RowOption.fromJson(item))
              .toList(),
    );
  }
}

class RowOption {
  final int id;
  final String name;
  final double price;

  RowOption({required this.id, required this.name, required this.price});

  factory RowOption.fromJson(Map<String, dynamic> json) {
    return RowOption(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
