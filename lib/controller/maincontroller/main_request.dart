import 'dart:convert';

import 'package:manjhi/controller/util/const_uris.dart';
import 'package:manjhi/model/mainmodel/disaster_model.dart';
import 'package:manjhi/model/mainmodel/emergency_helpline_model.dart';
import 'package:manjhi/model/mainmodel/essential_services_model.dart';
import 'package:manjhi/model/mainmodel/new_request_model.dart';
import 'package:manjhi/model/mainmodel/request_list_model.dart';
import 'package:http/http.dart' as http;


class MainRequest {

  Future<List<HelpRequest>> getHelpRequests(String user) async {
    List<HelpRequest> helpRequestList = [];
    var response = await http.post(
      Uri.parse(userRequestList),
      body: {
        'user' : user
      });
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      helpRequestList = json.map<HelpRequest>((json) => HelpRequest.fromJson(json)).toList();
    }
    return helpRequestList;
  }

  List<EmergencyHelpLine> area = [];
  String areaName = '';
  List<EmergencyHelpLine> district = [];
  String districtName = '';
  List<EmergencyHelpLine> state = [];
  String stateName = '';
  List<EmergencyHelpLine> country = [];
  String countryName = '';

  Future<void> getEmergencyHelplines(String user) async {
    var response = await http.post(
        Uri.parse(userCallList),
        body: {
          'user' : user
        });
    if (response.statusCode == 200) {
      var areaJson = jsonDecode(response.body)['area'];
      areaName = jsonDecode(response.body)['area_name'] as String;
      var districtJson = jsonDecode(response.body)['district'];
      districtName = jsonDecode(response.body)['district_name'] as String;
      var stateJson = jsonDecode(response.body)['state'];
      stateName = jsonDecode(response.body)['state_name'] as String;
      var countryJson = jsonDecode(response.body)['country'];
      countryName = jsonDecode(response.body)['country_name'] as String;
      area = areaJson.map<EmergencyHelpLine>((areaJson) => EmergencyHelpLine.fromJson(areaJson)).toList();
      district = districtJson.map<EmergencyHelpLine>((districtJson) => EmergencyHelpLine.fromJson(districtJson)).toList();
      state = stateJson.map<EmergencyHelpLine>((stateJson) => EmergencyHelpLine.fromJson(stateJson)).toList();
      country = countryJson.map<EmergencyHelpLine>((countryJson) => EmergencyHelpLine.fromJson(countryJson)).toList();
    }
  }

  Future<List<String>> getDisasters() async {
    List<Disaster> disasterList = [];
    List<String> list = [];
    var response = await http.get(Uri.parse(disasterType));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      disasterList = json.map<Disaster>((json) => Disaster.fromJson(json)).toList();
      for (Disaster dis in disasterList){
        list.add(dis.getName);
      }
    }
    return list;
  }

  Future<List<String>> getEssentialServices() async {
    List<EssentailService> essentialServiceList = [];
    List<String> list = [];
    var response = await http.get(Uri.parse(essentialServicesType));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body) as List;
      essentialServiceList = json.map<EssentailService>((json) => EssentailService.fromJson(json)).toList();
      for (EssentailService service in essentialServiceList){
        list.add(service.getName);
      }
    }
    return list;
  }

  Future<int> userHelpRequest(NewRequest request) async {
    var userRequestResponse = await http.post(
      Uri.parse(userRequest),
      body: {
        'user': request.getUser,
        'disaster': request.getDisaster,
        'eservice': request.getEssentialService,
        'request': request.getRequest,
        'is_emergency': request.getIsEmergency.toString()
      },
    );
    return userRequestResponse.statusCode;
  }

}