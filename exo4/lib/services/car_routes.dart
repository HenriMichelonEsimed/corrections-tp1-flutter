import 'package:exo4/model/car.dart';
import 'package:exo4/services/carapi.dart';
import 'package:http/http.dart' as http;

class CarRoutes extends CarAPI {
  static const carRoutes = '${CarAPI.apiUrl}/car';

  Future insert(Car car) async {
    var result = await http.post(Uri.http(CarAPI.apiServer, carRoutes), body: car.toMap());
    if (result.statusCode != 200) throw StatusErrorException(result.statusCode);
  }
}