import 'package:flutter_test/flutter_test.dart';
import 'package:iem_tracker/models/item_model.dart';
import 'package:iem_tracker/providers/items_provider.dart';

void main() {
  group('Items Class Test', () {
    test('Add item to the list', () {
      ItemsProvider itemsProvider = ItemsProvider();
      final item = ItemModel(title: 'Test Item', description: 'Test Description');
      itemsProvider.addItem(item);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].title, 'Test Item');
      expect(itemsProvider.items[0].description, 'Test Description');
    });

    test('Edit item in the list', () {
       ItemsProvider itemsProvider = ItemsProvider();
      final item1 = ItemModel(title: 'Item 1', description: 'Description 1');
      final item2 = ItemModel(title: 'Item 2', description: 'Description 2');
      itemsProvider.addItem(item1);
      itemsProvider.addItem(item2);

      itemsProvider.editItem('Updated Item', 'Updated Description', 0);

      expect(itemsProvider.items[0].title, 'Updated Item');
      expect(itemsProvider.items[0].description, 'Updated Description');
    });

    test('Remove item from the list', () {
       ItemsProvider itemsProvider = ItemsProvider();
      final item1 = ItemModel(title: 'Item 1', description: 'Description 1');
      final item2 = ItemModel(title: 'Item 2', description: 'Description 2');
      itemsProvider.addItem(item1);
      itemsProvider.addItem(item2);

      itemsProvider.removeItem(0);

      expect(itemsProvider.items.length, 1);
      expect(itemsProvider.items[0].title, 'Item 2');
    });
  });
}