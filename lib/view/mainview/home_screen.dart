import 'package:manjhi/controller/local_storage_controller.dart';
import 'package:manjhi/controller/maincontroller/main_controller.dart';
import 'package:manjhi/model/mainmodel/emergency_helpline_model.dart';
import 'package:manjhi/view/mainview/new_request_screen.dart';
import 'package:manjhi/view/util/widget/icon_text_row_button_widget.dart';
import 'package:manjhi/view/util/widget/icon_text_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<MainController>(context,listen: false).newRequest.setUser(
        Provider.of<LocalStorageController>(context,listen: false).credentials.getMobileNumber
    );
    _getEmergencyHelplines();
    _getHelpRequests();
  }

  void _getEmergencyHelplines() async {
    await Provider.of<MainController>(context,listen: false).getEmergencyHelplines();
    setState(() {});
  }

  void _getHelpRequests() async {
    await Provider.of<MainController>(context,listen: false).getHelpRequests();
    setState(() {});
  }

  Text headerTextWidget(String text) {
    return Text(text, style: const TextStyle(fontWeight: FontWeight.bold),);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }

  List<Widget> _addWidgets(List<EmergencyHelpLine> listHelpLine, String header) {
    List<Widget> widgets = [];
    widgets.add(headerTextWidget(header));
    for (EmergencyHelpLine helpLine in listHelpLine){
      widgets.add(TextIconRowButton(header: helpLine.getOrganization, text: helpLine.getContactNumber,));
    }
    return widgets;
  }

  List<Widget> _homeScreen() {
    List<Widget> widgets = [];
    if (Provider.of<MainController>(context,listen: false).request.area.isNotEmpty){
      widgets.addAll(_addWidgets(Provider.of<MainController>(context,listen: false).request.area,
          Provider.of<MainController>(context,listen: false).request.areaName));
    }
    if (Provider.of<MainController>(context,listen: false).request.district.isNotEmpty){
      widgets.addAll(_addWidgets(Provider.of<MainController>(context,listen: false).request.district,
          Provider.of<MainController>(context,listen: false).request.districtName));
    }
    if (Provider.of<MainController>(context,listen: false).request.state.isNotEmpty){
      widgets.addAll(_addWidgets(Provider.of<MainController>(context,listen: false).request.state,
          Provider.of<MainController>(context,listen: false).request.stateName));
    }
    if (Provider.of<MainController>(context,listen: false).request.country.isNotEmpty){
      widgets.addAll(_addWidgets(Provider.of<MainController>(context,listen: false).request.country,
          Provider.of<MainController>(context,listen: false).request.countryName));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('We are Here'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, NewRequestScreen.id),
        child: const Icon(Icons.list),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _getHelpRequests(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.08,
                vertical: MediaQuery.of(context).size.height * 0.01,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.all(
                    Radius.circular(MediaQuery.of(context).size.width * 0.08)
                ),
              ),
              child: Column(
                children: _homeScreen(),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                ),
                child: ListView.builder(
                    itemCount: Provider.of<MainController>(context,listen: true).helpRequestList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.08,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.08,
                            vertical: MediaQuery.of(context).size.height * 0.01,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(MediaQuery.of(context).size.width * 0.08)
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextIconRow(
                                header: 'Disaster Type',
                                text: Provider.of<MainController>(context,listen: true).helpRequestList.elementAt(index).getDisaster,
                              ),
                              TextIconRow(
                                header: 'Service Type',
                                text: Provider.of<MainController>(context,listen: true).helpRequestList.elementAt(index).getService,
                              ),
                              TextIconRow(
                                header: 'Request',
                                text: Provider.of<MainController>(context,listen: true).helpRequestList.elementAt(index).getRequest,
                              ),
                              TextIconRow(
                                header: 'Emergency',
                                text: Provider.of<MainController>(context,listen: true).helpRequestList.elementAt(index).getIsEmergency == true ? 'Yes' : 'No',
                              ),
                              TextIconRow(
                                header: 'In-Progress',
                                text: Provider.of<MainController>(context,listen: true).helpRequestList.elementAt(index).getIsInProgress == true ? 'Yes' : 'No',
                              ),
                              TextIconRow(
                                header: 'Complete',
                                text: Provider.of<MainController>(context,listen: false).helpRequestList.elementAt(index).getIsComplete == true ? 'Yes' : 'No',
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
