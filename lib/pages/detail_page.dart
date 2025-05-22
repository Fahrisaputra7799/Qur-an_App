import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_apps/pages/home_page.dart';
import '../models/ayah_model.dart';
import '../services/quran_service.dart';

class DetailPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const DetailPage({
    super.key,
    required this.surahNumber,
    required this.surahName,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<Ayah> ayahs = [];

  @override
  void initState() {
    super.initState();
    fetchAyahs();
  }

  Future<void> fetchAyahs() async {
    try {
      final result = await QuranService.fetchAyahs(widget.surahNumber);
      setState(() {
        ayahs = result;
      });
    } catch (e) {
      debugPrint('Error fetching ayahs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f4f8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed:
                              () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              ),
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xff437988),
                          ),
                        ),
                        Text(
                          widget.surahName,
                          style: GoogleFonts.poppins(
                            color: Color(0xff437988),
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child:
                        ayahs.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ).copyWith(bottom: 32),
                              itemCount: ayahs.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final ayah = ayahs[index];
                                return InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(25, 0, 0, 0),
                                          offset: Offset(0, 3),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          ayah.text,
                                          textAlign: TextAlign.right,
                                          style: GoogleFonts.amiri(
                                            fontSize: 26,
                                            height: 1.8,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Ayat ${ayah.numberInSurah}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
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
