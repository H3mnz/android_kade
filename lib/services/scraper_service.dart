import 'dart:developer';

import 'package:beautiful_soup_dart/beautiful_soup.dart';

class ScraperService {
  ScraperService._();
  static List<String>? getCategories(String html) {
    try {
      final soup = BeautifulSoup(html);
      final items = soup.find('div', class_: 'nd main-menu')?.find('ul', class_: 'right nd-absolute nd-bg')?.findAll('li');
      return items!.map((e) => e.text).toList();
    } catch (e) {
      log('ScraperService getAppsCategories => $e');
    }
    return null;
  }

  static List<Map<String, dynamic>>? parseData(String html) {
    try {
      final soup = BeautifulSoup(html);
      final articles = soup.find('section', class_: 'nd')!.findAll('article', class_: 'nd post-styleone');
      final list = <Map<String, dynamic>>[];
      for (var article in articles) {
        final a = article.find('div', class_: 'right img-link')?.find('a', class_: 'nd post-img');
        final id = a?.attributes['href']?.replaceAll('https://androidkade.com/', '').split('/').first;
        final image = a?.find('img')?.attributes['src'];
        final div = article.find('div', class_: 'right post-info')!;
        final title = div.find('div', class_: 'nd titles nd-center')?.find('h2')?.text;
        final desc = div.find('div', class_: 'nd post-bio')?.text;
        final time = div.find('div', class_: 'nd titles nd-center')?.find('li', class_: 'right nd-13 nd-medium time')?.text;
        final map = {
          'id': id,
          'title': title?.trim(),
          'image': image,
          'desc': desc?.trim(),
          'time': time?.trim(),
        };
        list.add(map);
      }
      return list;
    } catch (e) {
      log('ScraperService parseData => $e');
    }
    return null;
  }

  static Map? parseDetail(String html) {
    try {
      final soup = BeautifulSoup(html);
      final table = soup.find('table', class_: 'is-style-table-info')?.innerHtml;
      final items = soup.find('div', class_: 'nd dl-links')?.find('ul')?.findAll('li');
      final links = [];
      for (var item in items!) {
        final title = item.find('a')?.text;
        final link = item.find('a')?.attributes['href'];
        final map = {
          'title': title,
          'link': link,
        };
        links.add(map);
      }

      return {
        'info': table,
        'links': links,
      };
    } catch (e) {
      log('ScraperService getAppsCategories => $e');
    }
    return null;
  }
}
