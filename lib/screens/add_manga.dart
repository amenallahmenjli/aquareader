import 'package:aqua_reader/screens/manga_detail_screen.dart';
import 'package:flutter/material.dart';

class AddManga extends StatelessWidget {
  const AddManga({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text("Insert here the manga link:"),
            ),
            onSubmitted: (String value) async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MangaDetailScreenBuilder(link: value)));
            },
          ),
        ),
      ),
    );
  }
}
