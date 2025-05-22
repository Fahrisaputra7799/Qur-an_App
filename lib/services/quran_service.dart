import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/surah_model.dart';
import '../models/ayah_model.dart';

class QuranService {
  static const String baseUrl = 'https://api.alquran.cloud/v1';

  static Future<List<Surah>> fetchSurahList() async {
    final response = await http.get(Uri.parse('$baseUrl/surah'));
    if (response.statusCode == 200) {
          print(jsonDecode(response.body));
      final data = json.decode(response.body);
      return (data['data'] as List)
          .map((json) => Surah.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load surahs');
    }
  }

  static Future<List<Ayah>> fetchAyahs(int surahNumber) async {
    final response = await http.get(Uri.parse('$baseUrl/surah/$surahNumber'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['data']['ayahs'] as List)
          .map((json) => Ayah.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load ayahs');
    }
  }
}
