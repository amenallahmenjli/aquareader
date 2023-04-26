import 'package:flutter/material.dart';
import '../data/manga_detail_page.dart';
import 'package:expandable_text/expandable_text.dart';

// The goal of this class is to get the data and build the page's UI with it
class MangaDetailScreenBuilder extends StatefulWidget {
  final String link;

  const MangaDetailScreenBuilder({super.key, required this.link});

  @override
  State<MangaDetailScreenBuilder> createState() =>
      _MangaDetailScreenBuilderState();
}

class _MangaDetailScreenBuilderState extends State<MangaDetailScreenBuilder> {
  // Define a late variable to store manga informations
  late Future<Map<String, dynamic>> mangaDetail;

  @override
  void initState() {
    super.initState();

    // Get the data of the given manga
    mangaDetail = fetchMangaDetail(widget.link);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: mangaDetail,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else {
          if (snapshot.hasData) {
            final Map<String, dynamic> data = snapshot.data!;

            return MangaDetailScreen(
              data: data,
            );
          } else {
            return const Text("Waiting!");
          }
        }
      },
    );
  }
}

class MangaDetailScreen extends StatelessWidget {
  const MangaDetailScreen({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.download)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 125,
                      child: Image.network(
                        data['thumbnail'],
                        headers: const {
                          'accept':
                              'text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9',
                          'accept-language': 'en-US,en;q=0.9',
                          'sec-ch-ua':
                              '"Not_A Brand";v="99", "Google Chrome";v="109", "Chromium";v="109"',
                          'sec-ch-ua-mobile': '?0',
                          'sec-ch-ua-platform': '"Windows"',
                          'sec-fetch-dest': 'document',
                          'sec-fetch-mode': 'navigate',
                          'sec-fetch-site': 'none',
                          'sec-fetch-user': '?1',
                          'upgrade-insecure-requests': '1'
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        data['title'],
                        style: TextStyle(
                            fontSize: 21, fontWeight: FontWeight.w600),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Summary",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      ),
                      ExpandableText(
                        data['description'],
                        textAlign: TextAlign.justify,
                        expandText: "More",
                        collapseText: "Less",
                        maxLines: 4,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ])),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['chaptersList'].length.toString() + " Chapters",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.sort))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, bottom: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: data['chaptersList']
                    .map<Row>((e) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  e['num'].trim(),
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  e['date'],
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
