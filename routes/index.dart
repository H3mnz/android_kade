import 'package:dart_frog/dart_frog.dart';
import '../lib/services/_services.dart';
import '../lib/constants.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final typeQuery = context.request.uri.queryParameters['type'];
    final categoryQuery = context.request.uri.queryParameters['category'];
    final pageQuery = context.request.uri.queryParameters['page'];

    if (typeQuery != null && pageQuery != null) {
      if (androidTypes.containsKey(typeQuery) && int.tryParse(pageQuery) != null) {
        final type = androidTypes[typeQuery];
        final page = int.parse(pageQuery);
        late String? html;
        final category = categoryQuery ?? 'all';
        if (category != 'all') {
          html = await HttpService.get(baseUrl + 'android/$type/$category/page/$page');
        } else {
          html = await HttpService.get(baseUrl + 'android/$type/page/$page');
        }

        if (html != null) {
          final result = ScraperService.parseData(html);
          if (result != null) {
            return Response.json(
              body: {
                'page': page,
                'type': typeQuery,
                'category': category.replaceAll('-', ' '),
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
    body: {'message': 'Like that : /?type=apps&page=1'},
  );
}
