import 'package:dio/dio.dart';

import '../common/constants.dart';
import '../models/pakaian.dart';

// Service untuk mengambil data dari API menggunakan Dio
class ApiService {
  static const String baseUrl = Api.url;

  final Dio dio = Dio();

  Future<List<Pakaian>> getPakaianList() async {
    try {
      final response = await dio.get(baseUrl);
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Pakaian.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pakaian>> searchPakaianByCategory(String kategori) async {
    try {
      final response = await dio
          .get('$baseUrl/search', queryParameters: {'kategori': kategori});
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Pakaian.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Pakaian>> byId(int id) async {
    try {
      final response = await dio.get('$baseUrl/$id');
      final List<dynamic> responseData = response.data;
      return responseData.map((json) => Pakaian.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Pakaian> createPakaian(Pakaian pakaian) async {
    try {
      final response = await dio.post('$baseUrl/', data: {
        'nama': pakaian.nama,
        'image': pakaian.image,
        'deskripsi': pakaian.deskripsi,
        'kategori': pakaian.kategori,
        'kelamin': pakaian.kelamin,
        'usia': pakaian.usia,
        'status': pakaian.status,
        'harga': pakaian.harga,
      });
      return Pakaian.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Pakaian> updatePakaian(int id, Pakaian pakaian) async {
    try {
      final response = await dio.put('$baseUrl/$id', data: {
        'nama': pakaian.nama,
        'image': pakaian.image,
        'deskripsi': pakaian.deskripsi,
        'kategori': pakaian.kategori,
        'kelamin': pakaian.kelamin,
        'usia': pakaian.usia,
        'status': pakaian.status,
        'harga': pakaian.harga,
      });
      return Pakaian.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deletePakaian(int id) async {
    try {
      await dio.delete('$baseUrl/$id');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> statusDipesan(int id) async {
    String apiUrl = '$baseUrl/status/$id';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.followRedirects = false;
    dio.options.maxRedirects = 0;

    Map<String, dynamic> data = {'status': 'dipesan'};

    try {
      Response response = await dio.put(apiUrl, data: data);

      if (response.statusCode == 200) {
        print('Status updated successfully!');
      } else {
        print('Failed to update status. Response code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to update status: $error');
    }
  }

  Future<void> statusDisewa(int id) async {
    String apiUrl = '$baseUrl/status/$id';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.followRedirects = false;
    dio.options.maxRedirects = 0;

    Map<String, dynamic> data = {'status': 'disewa'};

    try {
      Response response = await dio.put(apiUrl, data: data);

      if (response.statusCode == 200) {
        print('Status updated successfully!');
      } else {
        print('Failed to update status. Response code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to update status: $error');
    }
  }

  Future<void> statusTersedia(int id) async {
    String apiUrl = '$baseUrl/status/$id';

    Dio dio = Dio();
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.followRedirects = false;
    dio.options.maxRedirects = 0;

    Map<String, dynamic> data = {'status': 'tersedia'};

    try {
      Response response = await dio.put(apiUrl, data: data);

      if (response.statusCode == 200) {
        print('Status updated successfully!');
      } else {
        print('Failed to update status. Response code: ${response.statusCode}');
      }
    } catch (error) {
      print('Failed to update status: $error');
    }
  }
}
