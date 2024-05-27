
// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, no_leading_underscores_for_local_identifiers, avoid_print, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:project_week8/database/datamodel.dart';

ValueNotifier<List<SignUpModel>>signup=ValueNotifier([]);

Future<bool>addData(SignUpModel value, BuildContext ctx)async{
  
final bookDB=await Hive.openBox<SignUpModel>('login_db');

await bookDB.add(value);
signup.value.add(value);
final errorMessage = 'Successfully signup';
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin:const EdgeInsets.all(16),
        content: Text(errorMessage),
      ));
print('sssss');
bookDB.close();
signup.notifyListeners();

return true;
}


Future<void>getAlldata()async{
final bookDB=await  Hive.openBox<SignUpModel>('login_db');
// ignore: avoid_print
print(bookDB);
signup.value.clear();
signup.value.addAll(bookDB.values);
signup.notifyListeners();


}


ValueNotifier<List<CategoryModel>>category=ValueNotifier([]);



Future<int> saveData(CategoryModel value) async {


  final saveDB = await Hive.openBox<CategoryModel>('save data');
  final _id = await saveDB.add(value);
  value.id = _id;
  await saveDB.put(_id, value);
  category.value.add(value);  
  saveDB.close();
  category.notifyListeners();
  return _id; // Return the ID
}

Future<void>updateCategory(CategoryModel updatedCategory)async{
  final saveDB=await Hive.openBox<CategoryModel>('save data');  
  saveDB.put(updatedCategory.id!,updatedCategory);
  category.value.clear();
  category.value.addAll(saveDB.values);
  saveDB.close();
  category.notifyListeners();
}

Future<void>deleteData(int id)async{
  final saveDB=await Hive.openBox<CategoryModel>('save data');
  await saveDB.delete(id);
  category.value.removeWhere((element) => element.id==id);
  category.notifyListeners();
}



ValueNotifier<List<ProductModel>>product=ValueNotifier([]);
Future<void> addProduct(ProductModel value) async {
  final productDB = await Hive.openBox<ProductModel>('product_value');
  
  final _id = await productDB.add(value);
  value.id = _id;
  
  // Update the product with the new ID
  await productDB.put(_id, value);
  
  print('success');
  product.value.add(value);
  product.notifyListeners();
}


Future<void>saveProduct()async{


  final productDB=await Hive.openBox<ProductModel>('product value');
  product.value.clear();
  product.value.addAll(productDB.values);
 
   
}




Future<void> deleteProduct(int id) async {
  final productDB = await Hive.openBox<ProductModel>('product value');
  productDB.delete(id);
  product.value.removeWhere((element) => element.id == id);
  product.notifyListeners();
}

Future<void> updateProduct(ProductModel updatedProduct) async {
  final productDB = await Hive.openBox<ProductModel>('product_value');
  if (updatedProduct.id != null) {
    await productDB.put(updatedProduct.id!, updatedProduct);
    product.value.clear();
    product.value.addAll(productDB.values);
    product.notifyListeners();
  }
  await productDB.close();
}




ValueNotifier<List<SellProductModel>>sell=ValueNotifier([]);

Future<void>addSellproduct(SellProductModel value)async{

final sellDB=await Hive.openBox<SellProductModel>('sell value');
// ignore: avoid_print
print('hello');
await sellDB.add(value);
sell.value.add(value);
sell.notifyListeners();

}
Future<void>saveSellProduct()async{

final sellDB=await Hive.openBox<SellProductModel>('sell value');
sell.value.clear();
sell.value.addAll(sellDB.values);
sell.notifyListeners();

}

Future<void> deleteSellProduct(int id) async {
  final sellDB = await Hive.openBox<SellProductModel>('sell value');
  sellDB.delete(id);
  sell.value.removeWhere((element) => element.id == id);
  sell.notifyListeners();
}
















