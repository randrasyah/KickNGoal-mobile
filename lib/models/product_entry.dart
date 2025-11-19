import 'dart:convert';

List<ProductEntry> productEntryFromJson(String str) => List<ProductEntry>.from(json.decode(str).map((x) => ProductEntry.fromJson(x)));

String productEntryToJson(List<ProductEntry> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductEntry {
    String id;
    String name;
    int price;
    String description;
    String thumbnail;
    String category;
    bool isFeatured;
    int productViews;
    DateTime createdAt;
    int stock;
    String brand;
    int userId;

    ProductEntry({
        required this.id,
        required this.name,
        required this.price,
        required this.description,
        required this.thumbnail,
        required this.category,
        required this.isFeatured,
        required this.productViews,
        required this.createdAt,
        required this.stock,
        required this.brand,
        required this.userId,
    });

    factory ProductEntry.fromJson(Map<String, dynamic> json) => ProductEntry(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        category: json["category"],
        isFeatured: json["is_featured"],
        productViews: json["product_views"],
        createdAt: DateTime.parse(json["created_at"]),
        stock: json["stock"],
        brand: json["brand"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "description": description,
        "thumbnail": thumbnail,
        "category": category,
        "is_featured": isFeatured,
        "product_views": productViews,
        "created_at": createdAt.toIso8601String(),
        "stock": stock,
        "brand": brand,
        "user_id": userId,
    };
}