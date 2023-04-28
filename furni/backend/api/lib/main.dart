import 'package:alfred/alfred.dart';
import 'package:furni_api/handlers/handlers.dart';
import 'package:furni_api/internals/data/furniture.dart';

void main() {
  final db = MockDB();
  print(db.getAllFurnitures());
  print(db.getFurnitureItemDetails(1));
  final app = Alfred();

  app.get('/healthcheck', healthcheck);

  app.listen(4242);
}
