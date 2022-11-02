import 'package:demo/src/models/user_data_model.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiCall {
  String baseUrl = "https://dummyapi.io/data/v1/user";

  Future<UserDataModel>? getUserData({String page = '1',String limit = '10'}) async {
  // getUserData() async {
    Response? res ;
    try {
        res = await Dio().get(baseUrl,
          queryParameters: {'page': page, 'limit': limit},
          options: Options(headers: {
          "Content-Type":"application/json",
            'app-id': '6360afae08dfca1378791d8e'}));
      // print(res.data.toString());
      // var resp = await http.get(
      //     Uri.https(baseUrl,"/data/v1/user", {'page': '1', 'limit': '10'}),
      //     headers: {
      //       "Content-Type": "application/json",
      //       'app-id': '6360afae08dfca1378791d8e'
      //     });
      // print(resp.body);
      return UserDataModel.fromJson(res.data);
    } catch (e) {
      print(e);
    }
     return UserDataModel.fromJson(res?.data);
  }
}
