import 'package:alfred/alfred.dart';

void main() {
  final app = Alfred();

  app.get('/hello', (req, res) {
    res.json({'message': 'Hello, Furni 👋'});
  });

  app.listen(4242);
}
