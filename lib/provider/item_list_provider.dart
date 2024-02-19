import 'package:crud_sqlite_flutter/database/db_helper.dart';
import 'package:crud_sqlite_flutter/model/item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final itemListProvider =
    StateNotifierProvider<ItemListNotifier, List<ItemModel>>((ref) {
  return ItemListNotifier(ref: ref);
});

class ItemListNotifier extends StateNotifier<List<ItemModel>> {
  final db = DbHelper();
  Ref ref;

  ItemListNotifier({required this.ref}) : super(List.empty()) {
    fetchItemList();
  }

  Future<void> fetchItemList() async {
    state = await db.fetchItems();
  }

  Future<void> addItem(ItemModel itemModel) async {
    await db.addItem(itemModel);
    fetchItemList();
  }

  Future<void> updateItem(ItemModel itemModel) async {
    await db.updateUser(itemModel.id, itemModel);
    fetchItemList();
  }

  Future<void> deleteItem(int itemId) async {
    await db.deleteItem(itemId);
    fetchItemList();
  }
}

final sharedPreferencesProvider = Provider((ref) {
  final DbHelper dbHelper = DbHelper();
  dbHelper.init();
  return dbHelper;
});

final itemNameControllerProvider = StateProvider<String>((ref) => "");
final itemPriceControllerProvider = StateProvider<String>((ref) => "");
final temporaryImagePathProvider = StateProvider<String>((ref) => "");
