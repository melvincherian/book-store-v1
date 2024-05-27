// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SignUpModelAdapter extends TypeAdapter<SignUpModel> {
  @override
  final int typeId = 1;

  @override
  SignUpModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SignUpModel(
      name: fields[0] as String,
      email: fields[1] as String,
      password: fields[2] as String,
      confirmPassword: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SignUpModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.confirmPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CategoryModelAdapter extends TypeAdapter<CategoryModel> {
  @override
  final int typeId = 2;

  @override
  CategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookModelAdapter extends TypeAdapter<BookModel> {
  @override
  final int typeId = 3;

  @override
  BookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookModel(
      id: fields[0] as int?,
      name: fields[1] as String,
      image: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BookModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 4;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      bookname: fields[0] as String,
      authorname: fields[1] as String,
      price: fields[2] as String,
      volume: fields[3] as String,
      count: fields[4] as String,
      id: fields[5] as int?,
      categoryName: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.bookname)
      ..writeByte(1)
      ..write(obj.authorname)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.volume)
      ..writeByte(4)
      ..write(obj.count)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.categoryName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SellProductModelAdapter extends TypeAdapter<SellProductModel> {
  @override
  final int typeId = 5;

  @override
  SellProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SellProductModel(
      name: fields[0] as String,
      phonenumber: fields[1] as String,
      product: fields[2] as String,
      discount: fields[3] as String,
      price: fields[4] as String,
      quantity: fields[6] as int,
      id: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SellProductModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phonenumber)
      ..writeByte(2)
      ..write(obj.product)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SellProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
