import 'package:flutter/material.dart';
import '../data/manga_detail_page.dart';

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
  final data;

  MangaDetailScreen({super.key, required this.data});

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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    data['thumbnail'],
                    headers: {
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
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
