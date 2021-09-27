import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseApiProvider{

  final String baseUrl = 'suapi.com/api';

  BaseApiProvider();

  Future<Map<String, dynamic>?> llamarApi(String subUrl, {Map<String, dynamic> params = const {}}) async{
    final uri = Uri.https(baseUrl, '/$subUrl');
    Response resp;

    try{
      resp = await http.post(
        uri,
        body: jsonEncode(params),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return null;
    }

    if(resp.statusCode != 201 && resp.statusCode != 200){
      print('ERROR');
      return null;
    }

    try{
      final decodedData = json.decode(resp.body);
      return decodedData;
    }
    catch(e, stacktrace){
      print(e);
      print(stacktrace);
      return null;
    }
  }

}