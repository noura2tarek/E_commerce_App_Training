class FavoritesModel{
  String? status;
  List<FavoriteProductModel>? favoriteProducts;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['favoriteProducts'] != null) {
      favoriteProducts = <FavoriteProductModel>[];
      json['favoriteProducts'].forEach((v) {
        favoriteProducts!.add(FavoriteProductModel.fromJson(v));
      });
    }
  }
}


class FavoriteProductModel {
  String? sId;
  String? status;
  String? category;
  String? name;
  dynamic price;
  String? description;
  String? image;
  List<String>? images;
  String? company;
  dynamic countInStock;
  dynamic iV;

  FavoriteProductModel(
      {this.sId,
        this.status,
        this.category,
        this.name,
        this.price,
        this.description,
        this.image,
        this.company,
        this.countInStock,
        this.iV,
      });

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    status = json['status'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    images = json['images'].cast<String>();
    company = json['company'];
    countInStock = json['countInStock'];
    iV = json['__v'];
  }

}