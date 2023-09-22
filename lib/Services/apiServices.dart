import 'package:al_dhaher/Config/constants.dart';
import 'package:http/http.dart' as http;

class Api {
  authData(data, apiUrl) async {
    var fullUrl = ApiConstants.baseUrl + apiUrl;
    return await http.post(Uri.parse(fullUrl), body: data);
  }
}

getData(apiUrl) async {
  var fullUrl = ApiConstants.baseUrl + apiUrl;
  return await http.get(
    Uri.parse(fullUrl),
  );
}
