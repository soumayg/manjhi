import 'package:manjhi/controller/maincontroller/main_request.dart';
import 'package:manjhi/model/mainmodel/new_request_model.dart';
import 'package:manjhi/model/mainmodel/request_list_model.dart';
import 'package:flutter/material.dart';

class MainController extends ChangeNotifier{
  MainRequest request = MainRequest();
  NewRequest newRequest = NewRequest();

  List<HelpRequest> helpRequestList = [];
  Future<List<HelpRequest>> getHelpRequests() async {
    helpRequestList.clear();
    helpRequestList = await request.getHelpRequests(newRequest.getUser);
    notifyListeners();
    return helpRequestList;
  }

  Future<void> getEmergencyHelplines() async {
    await request.getEmergencyHelplines(newRequest.getUser);
  }



  void getDisasterList() async {
    newRequest.setDisasterList(await request.getDisasters());
    newRequest.setDisaster(newRequest.getDisasterList.first);
    notifyListeners();
  }

  void getEssentialServiceList() async {
    newRequest.setEssentialServiceList(await request.getEssentialServices());
    newRequest.setEssentialService(newRequest.getEssentialServiceList.first);
    notifyListeners();
  }

  Future<bool> userRequest() async {
    int response = await request.userHelpRequest(newRequest);
    return response == 201 ? true: false;
  }

}