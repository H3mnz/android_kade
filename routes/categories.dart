import 'package:dart_frog/dart_frog.dart';
import '../lib/services/_services.dart';
import '../lib/constants.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final typeQuery = context.request.uri.queryParameters['type'];

    if (typeQuery != null) {
      if (androidTypes.containsKey(typeQuery)) {
        final type = androidTypes[typeQuery];
        final html = await HttpService.get(baseUrl + 'android/$type');
        if (html != null) {
          final result = ScraperService.getCategories(html);
          if (result != null) {
            return Response.json(
              body: {
                'type': typeQuery,
                'result': result,
              },
            );
          }
        }
      }
    }
  } catch (e) {
    print(e.toString());
  }
  return Response.json(
    statusCode: 404,
    body: {'message': 'Like that : /categories?type=apps'},
  );
}
