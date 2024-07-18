import 'package:flutter/material.dart';

class AddEditBottomSheetWidget extends StatelessWidget {
  final VoidCallback callback;
  final int? itemIndex;
  final bool isUpdate;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  const AddEditBottomSheetWidget({
    super.key,
    this.itemIndex,
    required this.callback,
    required this.isUpdate,
    required this.descriptionController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Please Enter Name',
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                    controller: nameController,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintStyle: const TextStyle(fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      hintText: 'Please Enter Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      callback();
                    },
                    child: Text(isUpdate ? 'Update Item' : 'Add Item'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
