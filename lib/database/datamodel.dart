
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



SignUpModel({required this.name,required this.email,required this.password,required this.confirmPassword});
  


}


@HiveType(typeId: 2)
class CategoryModel{

@HiveField(0)
int?id;

@HiveField(1)
final String name;

@HiveField(2)
late final String image;



CategoryModel({required this.id,required this.name,required this.image});






} 

@HiveType(typeId: 3)
class BookModel{

@HiveField(0)
int ?id;


@HiveField(1)
final String name;

@HiveField(2)
final String image;

BookModel({required this.id,required this.name,required this.image});





}
