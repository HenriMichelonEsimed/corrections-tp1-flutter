import 'dart:convert';
import 'package:exo3/models/breed.dart';
import 'package:exo3/models/image.dart';
import 'package:http/http.dart' as http;

class StatusErrorException {
  final int statusCode;
  const StatusErrorException(this.statusCode);
}

class CatAPI {
  static const apiServer = 'api.thecatapi.com';
  static const apiUrl = 'v1';
  static const apiKey = 'd016f309-0eca-4c47-a749-cc247aa403d7';
  static const apiKeyHeader = 'x-api-key';
  static const breedUrl = '$apiUrl/breeds';
  static const imageByBreedUrl = '$apiUrl/images/search';
  static const headers = { apiKeyHeader : apiKey };

  Future<List<Breed>> breeds() async {
    var result = await http.get(Uri.https(apiServer, breedUrl), headers: headers);
    if (result.statusCode == 200) {
      final List<dynamic> datas = jsonDecode(result.body);
      return datas.map((e) => Breed.fromMap(e)).toList();
    }
    throw StatusErrorException(result.statusCode);
  }

  Future<List<Image>> images(Breed breed) async {
    var result = await http.get(Uri.https(apiServer, imageByBreedUrl,
        {
          'limit' : '10',
          'breed_ids' : breed.id,
        }),
        headers: headers);
    if (result.statusCode == 200) {
      final List<dynamic> datas = jsonDecode(result.body);
      return datas.map((e) => Image.fromMap(e)).toList();
    }
    throw StatusErrorException(result.statusCode);
  }

}