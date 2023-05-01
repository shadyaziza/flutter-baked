import 'dart:async';

import 'package:alfred/alfred.dart';
import 'package:furni_api/internals/data/furniture.dart';

FutureOr<dynamic> healthcheckHandler(
    HttpRequest req, HttpResponse resp, MockDB db) {
  resp.statusCode = 200; // set the status code
  return {'status': 'available'};
}

FutureOr<dynamic> getFuntiruresHandler(
    HttpRequest req, HttpResponse resp, MockDB db) {
  final furnitureList = db.getAllFurnitures();
  resp.statusCode = 200; // set the status code
  return resp.json(furnitureList);
}

FutureOr<dynamic> getFurnitureDetailsHandler(
    HttpRequest req, HttpResponse resp, MockDB db) {
  final furnitureList = db.getFurnitureItemDetails(int.parse(req.params['id']));
  resp.statusCode = 200; // set the status code
  return resp.json(furnitureList);
}
