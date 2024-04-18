
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



// ValueNotifier<List<CategoryModel>>category=ValueNotifier([]);

// Future<void>saveData(CategoryModel value)async{
//   final saveDB=await Hive.openBox<CategoryModel>('save data');
//   // ignore: no_leading_underscores_for_local_identifiers
//   final _id =await saveDB.add(value);
//   value.id=_id;
//   await saveDB.add(value);
//   category.value.add(value);  
//   saveDB.close();
//   category.notifyListeners();

 
// }
// Future<void>updateCategory()async{
//   final saveDB=await Hive.openBox<CategoryModel>('save data');  
//   print(saveDB.values.toList());
//   category.value.clear();
//   category.value.addAll(saveDB.values);
// }

// Future<void>deleteData(int id)async{
// final saveDB=await Hive.openBox<CategoryModel>('save data');
//  await   saveDB.delete(id);
     
//  updateCategory();
// }

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














