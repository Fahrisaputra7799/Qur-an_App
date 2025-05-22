import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/surah_model.dart';
import '../services/quran_service.dart';
import '../widgets/category_selector.dart';
import '../widgets/surah_list_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Surah> surahs = [];
  String selectedCategory = 'Surah';
  List<int> bookmarkedSurahNumbers = [];

  @override
  void initState() {
    super.initState();
    fetchSurahs();
  }

  Future<void> fetchSurahs() async {
    try {
      final result = await QuranService.fetchSurahList();
      setState(() {
        surahs = result;
      });
    } catch (e) {
      print('Error fetching surahs: $e');
    }
  }

  Widget buildContent() {
    if (selectedCategory == 'Surah') {
      return SurahListView(
        surahs: surahs,
        onBookmarkTap: (surah) {
          setState(() {
            if (bookmarkedSurahNumbers.contains(surah.number)) {
              bookmarkedSurahNumbers.remove(surah.number);
            } else {
              bookmarkedSurahNumbers.add(surah.number);
            }
          });
        },
        isBookmarked: (surah) => bookmarkedSurahNumbers.contains(surah.number),
      );
    } else if (selectedCategory == 'Hafalan') {
      // Filter surah yang sudah dibookmark saja
      final bookmarkedSurahs =
          surahs
              .where((surah) => bookmarkedSurahNumbers.contains(surah.number))
              .toList();

      if (bookmarkedSurahs.isEmpty) {
        return Center(
          child: Text(
            'Belum Ada Hafalan',
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        );
      }

      return SurahListView(
        surahs: bookmarkedSurahs,
        onBookmarkTap: (surah) {
          setState(() {
            bookmarkedSurahNumbers.remove(surah.number);
          });
        },
        isBookmarked: (surah) => true, // karena sudah pasti bookmarked di sini
      );
    } else {
      return Center(
        child: Text(
          'Coming Soon',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Al-Qur\'an',
                          style: GoogleFonts.poppins(
                            color: Color(0xff437988),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  /// CATEGORY SELECTOR
                  CategorySelector(
                    selected: selectedCategory,
                    onSelected: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  /// CONTENT
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: buildContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
