import 'package:flutter/material.dart';
import 'package:quran_apps/models/surah_model.dart';
import 'package:quran_apps/pages/detail_page.dart';
import 'package:quran_apps/widgets/surah_tile.dart';

class SurahListView extends StatelessWidget {
  final List<Surah> surahs;
  final Function(Surah) onBookmarkTap;
  final bool Function(Surah) isBookmarked;

  const SurahListView({
    super.key,
    required this.surahs,
    required this.onBookmarkTap,
    required this.isBookmarked,
  });

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
          onBookmarkTap: () => onBookmarkTap(surah),
          isBookmarked: isBookmarked(surah),
        );
      },
    );
  }
}
