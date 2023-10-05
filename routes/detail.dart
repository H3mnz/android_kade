import 'package:dart_frog/dart_frog.dart';
import '../lib/services/_services.dart';
import '../lib/constants.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final idQuery = context.request.uri.queryParameters['id'];

    if (idQuery != null) {
      final id = int.parse(idQuery);
      final html = await HttpService.get(baseUrl + '$id');
      if (html != null) {
        final result = ScraperService.parseDetail(html);
        if (result != null) {
          return Response.json(
            body: result,
          );
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return Response.json(
    statusCode: 404,
    body: {'message': 'Like that : /detail?id=32895'},
  );
}
