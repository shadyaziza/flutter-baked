import 'dart:io';
import 'dart:convert';

// "type": "sofa 1", "cabinet 2", "table 3", "chair 4", "bookshelf 5"

class FurnitureType {
  final int id;
  String name;
  FurnitureType({
    required this.id,
    required this.name,
  });
}

/// Data model to view details on multiple furniture items
///
class FurnitureListItem {
  final int id;
  int type; // references FurnitureType.id
  String name;
  double price;
  String imageUrl;

  FurnitureListItem({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory FurnitureListItem.fromJson(Map<String, dynamic> json) {
    return FurnitureListItem(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}

/// Data model to view details on multiple furniture items
///
class FurnitureItemDetails {
  final int id;
  int type; // references FurnitureType.id
  String name;
  double price;
  String style;
  double height;
  double width;
  double depth;
  String imageUrl;

  FurnitureItemDetails({
    required this.id,
    required this.type,
    required this.name,
    required this.price,
    required this.style,
    required this.height,
    required this.width,
    required this.depth,
    required this.imageUrl,
  });

  factory FurnitureItemDetails.fromJson(Map<String, dynamic> json) {
    return FurnitureItemDetails(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      price: json['price'],
      style: json['style'],
      height: json['height'],
      width: json['width'],
      depth: json['depth'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'name': name,
      'price': price,
      'style': style,
      'height': height,
      'width': width,
      'depth': depth,
      'imageUrl': imageUrl,
    };
  }
}

class MockDB {
  late Map<String, dynamic> parsedJson;

  static MockDB? _instance;

  MockDB._() {
    final jsonString =
        File('${Directory.current.path}/../../db/mock.json').readAsStringSync();

    parsedJson = JsonDecoder().convert(jsonString);
  }

  factory MockDB.init() {
    if (_instance == null) {
      _instance = MockDB._();
    }
    return _instance!;
  }

  FurnitureItemDetails? getFurnitureItemDetails(int id) {
    final jsonItem = (parsedJson['funritureList'] as List).firstWhere(
      (item) => item['id'] == id,
      orElse: () => null,
    );

    if (jsonItem == null) return null;

    return FurnitureItemDetails.fromJson(jsonItem);
  }

  List<FurnitureListItem> getAllFurnitures() {
    final result = (parsedJson['funritureList'] as List).map((item) {
      return FurnitureListItem.fromJson(item);
    }).toList();
    return result;
  }
}
