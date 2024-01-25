import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';

void main() {
  group("Restaurant Provider Test", () {
    test('Parsing JSON', () async {
      const jsonData = '''{
        "id": "abcd123",
        "name": "cafe",
        "description": "description",
        "pictureId": "14",
        "city": "Bandung",
        "rating": 5.0
      }''';

      final data = DataItemListRestaurant.fromJson(json.decode(jsonData));

      expect(data.id, "abcd123");
      expect(data.name, "cafe");
      expect(data.description, "description");
      expect(data.pictureId, "14");
      expect(data.city, "Bandung");
      expect(data.rating, 5.0);
    });
  });
}
