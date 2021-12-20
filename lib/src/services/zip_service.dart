import '../datas/zip_data.dart';
import 'package:http/http.dart' as http;


class GetZip {
  static Future<ResultZip> fetchZip({required String zip}) async {
    final response = await http.get(Uri.https('viacep.com.br','ws/$zip/json/'));
    if (response.statusCode == 200) {
      return ResultZip.fromJson(response.body);
    } else {
      print(response.body);
      throw Exception('Requisição inválida!');
    }
  }
}