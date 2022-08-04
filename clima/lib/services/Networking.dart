// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;

     
      return jsonDecode(data);
      

      // double temprature = jsonDecode(data)['main']['temp'];
      // int condition = jsonDecode(data)['weather'][0]['id'];
      // String cityname = jsonDecode(data)['name'];
      //  print(temprature);
      // print(condition);
      // print(cityname);
    } else {
      print(response.statusCode);
    }
  }
}
