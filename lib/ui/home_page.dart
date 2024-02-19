import 'package:crud_sqlite_flutter/model/item_model.dart';
import 'package:crud_sqlite_flutter/provider/item_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import '../utils/modal_bottom_sheet.dart';
import '../widget/item_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modal = ModalBottomSheet();

    Future<List<ItemModel>> getItemList() async {
      return ref.watch(itemListProvider);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "SQLITE CRUD",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<ItemModel>>(
        future: getItemList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          } else {
            final List<ItemModel> itemlist = snapshot.data!;

            return itemlist.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'No Item Available',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: itemlist.length,
                    itemBuilder: (context, index) => ItemWidget(
                      itemModel: itemlist[index],
                    ),
                  );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          modal.showBottomSheet(context, ItemModel());
        },
        backgroundColor: Colors.blueAccent,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
