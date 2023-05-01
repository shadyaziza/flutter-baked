import 'package:alfred/alfred.dart';
import 'package:furni_api/handlers/handlers.dart';
import 'package:furni_api/internals/data/furniture.dart';

void main() {
  final app = Alfred();

  app.get(
    '/healthcheck',
    (req, res) => healthcheckHandler(req, res, app.db),
  );
  app.get(
    '/furnitures',
    (req, res) => getFuntiruresHandler(req, res, app.db),
  );
  app.get(
    '/furnitures/:id',
    (req, res) => getFurnitureDetailsHandler(req, res, app.db),
  );

  app.listen(4242);
}

extension on Alfred {
  get db => MockDB.init();
}
