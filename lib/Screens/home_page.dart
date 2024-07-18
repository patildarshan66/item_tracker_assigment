import 'package:flutter/material.dart';
import 'package:iem_tracker/widgets/add_edit_bottomsheet_widget.dart';

import 'package:iem_tracker/models/item_model.dart';

import 'package:iem_tracker/providers/items_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey _containerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Item List'),
        actions: [
          ElevatedButton(
            onPressed: _getSizeAndPosition,
            child: const Text('Get Size and Position'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemBottomSheet(context);
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ItemsProvider>(builder: (context, itemProvider, child) {
        return ListView.builder(
            shrinkWrap: true,
            key: _containerKey,
            itemCount: itemProvider.items.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: const BorderSide(
                        color: Colors.deepPurple, // Border color
                        width: 1.0,
                      )), // Border width

                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemProvider.items[i].title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              Text(itemProvider.items[i].description),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 255, 127, 7),
                              ),
                              onPressed: () {
                                itemProvider.removeItem(i);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                _showEditItemBottomSheet(context, i);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

  void _showAddItemBottomSheet(BuildContext context) {
    _nameController.clear();
    _descriptionController.clear();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return AddEditBottomSheetWidget(
          isUpdate: false,
          nameController: _nameController,
          descriptionController: _descriptionController,
          callback: () {
            if (_nameController.text.isNotEmpty &&
                _descriptionController.text.isNotEmpty) {
              Provider.of<ItemsProvider>(context, listen: false).addItem(ItemModel(
                  description: _descriptionController.text,
                  title: _nameController.text));
            }
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void _getSizeAndPosition() {
    final RenderBox renderBox =
        _containerKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final position = renderBox.localToGlobal(Offset.zero);

    print('Size: $size');
    print('Position: $position');
  }

  void _showEditItemBottomSheet(BuildContext context, int index) {
    final itemList = Provider.of<ItemsProvider>(context, listen: false);
    _nameController.text = itemList.items[index].title;
    _descriptionController.text = itemList.items[index].description;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddEditBottomSheetWidget(
          isUpdate: true,
          itemIndex: index,
          nameController: _nameController,
          descriptionController: _descriptionController,
          callback: () {
            Provider.of<ItemsProvider>(context, listen: false).editItem(
                _nameController.text, _descriptionController.text, index);
            Navigator.pop(context);
          },
        );
      },
    );
  }

}
