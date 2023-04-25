import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

Future<Map<String, dynamic>> fetchMangaDetail(String link) async {
  final response = await http.get(Uri.parse(link), headers: {
    'accept':
        'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
    'accept-language': 'en-US,en;q=0.9',
    'sec-ch-ua':
        '\"Not_A Brand\";v=\"99\", \"Google Chrome\";v=\"109\", \"Chromium\";v=\"109\"',
    'sec-ch-ua-mobile': '?0',
    'sec-ch-ua-platform': '\"Windows\"',
    'sec-fetch-dest': 'document',
    'sec-fetch-mode': 'navigate',
    'sec-fetch-site': 'none',
    'sec-fetch-user': '?1',
    'upgrade-insecure-requests': '1'
  });

  print(response.statusCode);

  if (response.statusCode == 200) {
    final document = parse(response.body);

    final title = document
        .getElementsByClassName('post-title')[0]
        .querySelector('H1')!
        .text
        .trim();

    final thumbnail = document
        .getElementsByClassName('summary_image')[0]
        .children[0]
        .children[0]
        .attributes
        .entries
        .elementAt(2)
        .value
        .trim();

    var description = '';

    document
        .getElementsByClassName('description-summary')[0]
        .children[0]
        .children
        .sublist(3)
        .forEach((e) => description += e.text + '\n');

    final chaptersList =
        document.getElementsByClassName('wp-manga-chapter    ').map((e) => {
              'num': e.querySelector('a')?.innerHtml,
              'link': e.querySelector('a')?.attributes['href'],
              'date': e.querySelector('span')?.children[0].innerHtml
            });

    final data = {
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'chaptersList': chaptersList
    };
    return data;
  } else {
    return {};
  }
}
