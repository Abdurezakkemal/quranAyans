import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/ayah.dart';

class QuranService {
  static const String baseUrl = 'http://api.alquran.cloud/v1';
  
  // Total number of ayahs in the Quran
  static const int totalAyahs = 6236;

  /// Fetches a random ayah from the Quran
  Future<ApiResponse> getRandomAyah() async {
    try {
      // Generate a random ayah number between 1 and 6236
      final random = Random();
      final randomAyahNumber = random.nextInt(totalAyahs) + 1;
      
      return await getAyahByNumber(randomAyahNumber);
    } catch (e) {
      throw Exception('Failed to fetch random ayah: $e');
    }
  }

  /// Fetches a specific ayah by its number
  Future<ApiResponse> getAyahByNumber(int ayahNumber) async {
    try {
      final url = Uri.parse('$baseUrl/ayah/$ayahNumber');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ApiResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load ayah. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Fetches a specific ayah with translation
  Future<ApiResponse> getAyahWithTranslation(int ayahNumber, {String edition = 'en.asad'}) async {
    try {
      final url = Uri.parse('$baseUrl/ayah/$ayahNumber/$edition');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ApiResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load ayah with translation. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  /// Fetches a random ayah with English translation
  Future<ApiResponse> getRandomAyahWithTranslation({String edition = 'en.asad'}) async {
    try {
      // Generate a random ayah number between 1 and 6236
      final random = Random();
      final randomAyahNumber = random.nextInt(totalAyahs) + 1;
      
      return await getAyahWithTranslation(randomAyahNumber, edition: edition);
    } catch (e) {
      throw Exception('Failed to fetch random ayah with translation: $e');
    }
  }

  /// Fetches ayah by surah and verse number (e.g., 2:255 for Ayat Al-Kursi)
  Future<ApiResponse> getAyahBySurahAndVerse(int surahNumber, int verseNumber, {String? edition}) async {
    try {
      String url = '$baseUrl/ayah/$surahNumber:$verseNumber';
      if (edition != null) {
        url += '/$edition';
      }
      
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return ApiResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load ayah. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
