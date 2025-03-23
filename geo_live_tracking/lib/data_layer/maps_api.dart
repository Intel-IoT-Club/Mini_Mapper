import 'dart:convert';

import 'package:geo_live_tracking/config.dart';
import 'package:geo_live_tracking/models/auto_complete_model.dart';
import 'package:geo_live_tracking/models/geo_model.dart';
import 'package:geo_live_tracking/models/rev_geo_model.dart';
import 'package:http/http.dart' as http;

class MapsApi {
  final String api = AppConfig.api_key;

  Future<T> getAutoComplete<T>(String input) async{
    final url = "${AppConfig.auto_complete_url}?input=$input&key=$api";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = json.decode(response.body);
      AutoCompleteModel autoCompleteModel = AutoCompleteModel.fromJson(body);
  
      return autoCompleteModel as T;
    }else{
      ErrorModel errorModel = ErrorModel(message: "Something went wrong");
      return errorModel as T;
    }
  }

Future<T> getReverseGeoCode<T>(double lat, double lng) async{
    final url = "${AppConfig.geocoding_url}?latlng=$lat,$lng&key=$api";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = json.decode(response.body);
      RevGeoModel revGeoModel = RevGeoModel.fromJson(body);
 
      return revGeoModel as T;
    }else{
      ErrorModel errorModel = ErrorModel(message: "Something went wrong");
      return errorModel as T;
    }
  }

  Future<T> getGeoCode<T>(String address)async{
    final url = "${AppConfig.geocoding_url}?address=$address&key=$api";
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body = json.decode(response.body);
      GeoModel revGeoModel = GeoModel.fromJson(body);
      return revGeoModel as T;
    }else{
      ErrorModel errorModel = ErrorModel(message: "Something went wrong");
      return errorModel as T;
    }
  }

  
}