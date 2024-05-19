import 'package:hive_flutter/adapters.dart';
part 'datamodel.g.dart';

@HiveType(typeId: 1)
class SignUpModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String password;

  @HiveField(3)
  final String confirmPassword;

  SignUpModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.confirmPassword});
}

@HiveType(typeId: 2)
class CategoryModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  late final String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

@HiveType(typeId: 3)
class BookModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String image;

  BookModel({required this.id, required this.name, required this.image});
}

@HiveType(typeId: 4)
class ProductModel {
  @HiveField(0)
  final String bookname;

  @HiveField(1)
  final String authorname;

  @HiveField(2)
  final String price;

  @HiveField(3)
  final String volume;

  @HiveField(4)
  final String count;
  
  @HiveField(5)
  int? id;

  @HiveField(6)
  final String categoryName;

  ProductModel({
    required this.bookname,
    required this.authorname,
    required this.price,
    required this.volume,
    required this.count,
    required this.id,
    required this.categoryName,

  });
}

@HiveType(typeId: 5)
class SellProductModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String phonenumber;

  @HiveField(2)
  final String product;

  @HiveField(3)
  final String discount;

  @HiveField(4)
  final String price;

  @HiveField(5)
  int? id;

  SellProductModel({
    required this.name,
    required this.phonenumber,
    required this.product,
    required this.discount,
    required this.price,
    required this.id,
  });
}
