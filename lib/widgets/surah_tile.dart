import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_apps/models/surah_model.dart';

class SurahTile extends StatelessWidget {
  final Surah surah;
  final VoidCallback onTap;
  final VoidCallback onBookmarkTap;
  final bool isBookmarked;

  const SurahTile({
    super.key,
    required this.surah,
    required this.onTap,
    required this.onBookmarkTap,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.black.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.teal.withOpacity(0.2),
          highlightColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(20, 0, 0, 0),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.auto_stories_outlined, color: Color(0xff437988)),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${surah.number}. ${surah.englishName}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Surah : ${surah.englishName}, terdiri dari : ${surah.numberOfAyahs} ayat',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onBookmarkTap,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                    color: const Color(0xff437988),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
