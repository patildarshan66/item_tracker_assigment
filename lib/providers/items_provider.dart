import 'package:flutter/material.dart';
import 'package:iem_tracker/models/item_model.dart';

class ItemsProvider with ChangeNotifier {
  final List<ItemModel> _items = [];

  List<ItemModel> get items => _items;

  /// To add item into list
  void addItem(ItemModel item) {
    _items.add(item);
    notifyListeners();
  }

  /// To edit item from list
  void editItem(String title, String description, int index) {
    _items[index] = ItemModel(title: title, description: description);
    notifyListeners();
  }

  /// To remove item from list
  void removeItem(int itemIndex) {
    _items.removeAt(itemIndex);
    notifyListeners();
  }
}
