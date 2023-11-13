import '../../constants/api_endpoints.dart';
import '../api_services.dart';

class FitnessAppApiProvider {
  ApiServices api = ApiServices();

  Future<dynamic> getData() async {
    var url = ApiUrl.testUrl;
    var response = await api.get(url);
    if (response != null) {
      dynamic data;
      return data;
    }
    return null;
  }
}
