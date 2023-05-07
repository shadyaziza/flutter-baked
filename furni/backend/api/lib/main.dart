import 'package:alfred/alfred.dart';
import 'package:furni_api/handlers/handlers.dart';
import 'package:furni_api/internals/data/furniture.dart';

void main() {
  final app = Alfred();
  final db = MockDB.init();

  app.get(
    '/healthcheck',
    (req, res) => healthcheckHandler(req, res, db),
  );
  app.get(
    '/furnitures',
    (req, res) => getFuntiruresHandler(req, res, db),
  );
  app.get(
    '/furnitures/:id',
    (req, res) => getFurnitureDetailsHandler(req, res, db),
  );

  app.listen(4242);
}
