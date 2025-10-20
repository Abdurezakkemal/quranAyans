import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/ayah.dart';

class QuranService {
  String baseUrl = 'http://api.alquran.cloud/v1';

  Future<ApiResponse> getRandomAyah() async {
    Random random = Random();
    int randomNumber = random.nextInt(6236) + 1;

    String url = baseUrl + '/ayah/' + randomNumber.toString();

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(data);
      return apiResponse;
    } else {
      throw Exception('Error loading ayah');
    }
  }

  Future<ApiResponse> getAyahByNumber(int number) async {
    String url = baseUrl + '/ayah/' + number.toString();

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(data);
      return apiResponse;
    } else {
      throw Exception('Error loading ayah');
    }
  }

  Future<ApiResponse> getAyahBySurahAndVerse(
    int surahNumber,
    int verseNumber,
  ) async {
    String url =
        baseUrl +
        '/ayah/' +
        surahNumber.toString() +
        ':' +
        verseNumber.toString();

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromJson(data);
      return apiResponse;
    } else {
      throw Exception('Error loading');
    }
  }
}
