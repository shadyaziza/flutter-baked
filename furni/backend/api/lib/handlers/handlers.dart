import 'dart:async';
import 'dart:convert';

import 'package:alfred/alfred.dart';
import 'package:furni_api/internals/data/furniture.dart';

FutureOr<dynamic> healthcheckHandler(HttpRequest req, HttpResponse resp) {
  resp.statusCode = 200; // set the status code
  return json.encode({'status': 'available'});
}

FutureOr<dynamic> getFuntiruresHandler(
    HttpRequest req, HttpResponse resp, DB db) async {
  final furnitureList = await db.getAllFurnitures();
  resp.statusCode = 200; // set the status code
  return json.encode({'furnitures': furnitureList});
}

FutureOr<dynamic> getFurnitureDetailsHandler(
    HttpRequest req, HttpResponse resp, DB db) async {
  final strId = req.params['id'];
  final id = int.tryParse(strId);

  if (id == null) {
    // this means that the provided id is not an actual int
    resp.statusCode =
        400; // letting the client know that they have sent a bad request
    return json.encode({
      'message': 'could not parse $strId as int'
    }); // send an empty json response, you can also customize this as fits
  }

  if (id <= 0) {
    // ids usually are auto increment values that starts from 1
    resp.statusCode = 404;
    return json
        .encode({'message': 'could not find furniture item of id = $id'});
  }

  final furnitureItem = await db.getFurnitureItemDetails(id);

  if (furnitureItem == null) {
    // if we can not find the requested item in the database

    resp.statusCode = 404;
    return json
        .encode({'message': 'could not find furniture item of id = $id'});
  }

  resp.statusCode = 200; // set the status code
  return json.encode(furnitureItem.toJson());
}
