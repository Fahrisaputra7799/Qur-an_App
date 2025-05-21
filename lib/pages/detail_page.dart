import 'package:flutter/material.dart';
import '../models/ayah_model.dart';
import '../services/quran_service.dart';

class DetailPage extends StatefulWidget {
  final int surahNumber;
  final String surahName;

  const DetailPage({required this.surahNumber, required this.surahName});

  @override
  _DetailPageState createState() => _DetailPageState();
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
      print('Error fetching ayahs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.surahName)),
      body: ayahs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: ayahs.length,
              itemBuilder: (context, index) {
                final ayah = ayahs[index];
                return ListTile(
                  title: Text(
                    ayah.text,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text('Ayat ${ayah.numberInSurah}'),
                );
              },
            ),
    );
  }
}
