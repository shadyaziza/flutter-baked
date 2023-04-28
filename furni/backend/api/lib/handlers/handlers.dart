import 'dart:async';

import 'package:alfred/alfred.dart';

FutureOr<dynamic> healthcheck(HttpRequest req, HttpResponse resp) {
  resp.statusCode = 200; // set the status code
  return {'status': 'available'};
}
