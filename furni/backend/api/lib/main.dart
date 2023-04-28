import 'package:alfred/alfred.dart';
import 'package:furni_api/handlers/handlers.dart';

void main() {
  final app = Alfred();

  app.get('/healthcheck', healthcheck);

  app.listen(4242);
}
