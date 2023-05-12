import 'package:alfred/alfred.dart';
import 'package:furni_api/handlers/handlers.dart';
import 'package:furni_api/internals/data/furniture.dart';

Future<void> main() async {
  final app = Alfred();
  final db = DB.init();
  await db.connection.open();

  app.get(
    '/healthcheck',
    healthcheckHandler,
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
