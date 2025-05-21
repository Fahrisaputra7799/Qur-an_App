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
      return SurahListView(surahs: surahs);
    } else {
      return Text(
        'Cooming Soon',
        style: GoogleFonts.poppins(color: Colors.black),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 900),
          child: Container(
            padding: EdgeInsets.only(top: 12),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    'Selected Sura',
                    style: GoogleFonts.poppins(
                      color: Color(0xff437988),
                      fontSize: 32,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('To Read', style: GoogleFonts.montserrat(
                    color: Color(0xff437988),
                    fontSize: 24
                  ),),
                ),
                const SizedBox(height: 16),
                CategorySelector(
                  selected: selectedCategory,
                  onSelected: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: buildContent(),
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
