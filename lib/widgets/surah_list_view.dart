import 'package:flutter/material.dart';
import '../models/surah_model.dart';
import '../pages/detail_page.dart';
import 'surah_tile.dart';

class SurahListView extends StatelessWidget {
  final List<Surah> surahs;

  const SurahListView({super.key, required this.surahs});

  @override
  Widget build(BuildContext context) {
    if (surahs.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        return SurahTile(
          surah: surah,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailPage(
                  surahNumber: surah.number,
                  surahName: surah.englishName,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
