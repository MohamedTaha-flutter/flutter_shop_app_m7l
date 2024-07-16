class HomeModel {
  final bool status;
  final DataHomeModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromJson(json) {
    return HomeModel(
      status: json["status"],
      data: DataHomeModel.fromJson(json["data"]),
    );
  }
}
//class HomeDataModel {
//   List<BannerModel> banners = [];
//   List<ProductModel> products = [];
//
//   HomeDataModel.fromJson(Map<String, dynamic> json) {
//     json['banners'].forEach((element) {
//       banners.add(BannerModel.fromJson(element));
//     });
//
//     json['products'].forEach((element) {
//       products.add(ProductModel.fromJson(element));
//     });
//   }
// }
// AM
// Add reply
class DataHomeModel {
  final List<BannersDataHomeModel> banners = [];

  final List<ProductsDataHomeModel> products = [];

  DataHomeModel.fromJson(json) {
    json["banners"].forEach((element) {
      banners.add(BannersDataHomeModel.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductsDataHomeModel.fromJson(element));
    });
  }
}

class BannersDataHomeModel {
  final int id;
  final String image;

  BannersDataHomeModel({required this.image, required this.id});

  factory BannersDataHomeModel.fromJson(json) {
    return BannersDataHomeModel(
      id: json["id"],
      image: json["image"],
    );
  }
}

class ProductsDataHomeModel {
  final int id;
  final dynamic price;
  final dynamic old_price;
  final dynamic discount;
  final String image;
  final String name;
  final bool in_favorites;
  final bool in_cart;

  ProductsDataHomeModel({
    required this.id,
    required this.price,
    required this.old_price,
    required this.discount,
    required this.image,
    required this.name,
    required this.in_favorites,
    required this.in_cart,
  });

  factory ProductsDataHomeModel.fromJson(json) {
    return ProductsDataHomeModel(
      id: json["id"],
      price: json["price"],
      old_price: json["old_price"],
      discount: json["discount"],
      image: json["image"],
      name: json["name"],
      in_favorites: json["in_favorites"],
      in_cart: json["in_cart"],
    );
  }
}
