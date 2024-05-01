
// ignore_for_file: invalid_use_of_visible_for_testing_member

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






ValueNotifier<List<BookModel>>subcategory=ValueNotifier([]);


Future<void>subData(BookModel value)async{


final subcategoryDB=await Hive.openBox<BookModel>('sub category');
  final _id =await subcategoryDB.add(value);
  value.id=_id;
await subcategoryDB.add(value);
subcategory.value.add(value);
subcategoryDB.close();
subcategory.notifyListeners();



}

Future<void>updatebookcategory()async{
  final subcategoryDB=await Hive.openBox('sub category');
  subcategory.value.clear();
  subcategory.value.addAll(subcategoryDB.values.cast<BookModel>().toList());
}

Future<void>deletebookcategory(int id)async{

final subcategoryDB=await Hive.openBox<BookModel>('sub category');

await subcategoryDB.delete(id);
updatebookcategory();
}




ValueNotifier<List<ProductModel>>product=ValueNotifier([]);

Future<void>addProduct(ProductModel value)async{

  final productDB=await Hive.openBox<ProductModel>('product value');
  await productDB.add(value);
  print('success');
  product.value.add(value);
  product.notifyListeners();
   
}
Future<void>saveProduct()async{
  final productDB=await Hive.openBox<ProductModel>('product value');
  product.value.clear();
  product.value.addAll(productDB.values);
  product.notifyListeners();
   
}

ValueNotifier<List<SellProductModel>>sell=ValueNotifier([]);

Future<void>addSellproduct(SellProductModel value)async{

final sellDB=await Hive.openBox<SellProductModel>('sell value');
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

















