import 'package:manjhi/controller/local_storage_controller.dart';
import 'package:manjhi/controller/maincontroller/main_controller.dart';
import 'package:manjhi/view/util/widget/custom_text_form_field_widget.dart';
import 'package:manjhi/view/util/widget/customize_checkbox_widget.dart';
import 'package:manjhi/view/util/widget/dropdown_option_widget.dart';
import 'package:manjhi/view/util/widget/push_replacement_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class NewRequestScreen extends StatefulWidget {
  const NewRequestScreen({Key? key}) : super(key: key);
  static String id = 'NewRequestScreen';

  @override
  State<NewRequestScreen> createState() => _NewRequestScreenState();
}

class _NewRequestScreenState extends State<NewRequestScreen> {

  final _formNewRequest = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<MainController>(context,listen: false).newRequest.setUser(
        Provider.of<LocalStorageController>(context,listen: false).credentials.getMobileNumber
    );
    _getList();
  }

  void _getList(){
    Provider.of<MainController>(context,listen:false).getDisasterList();
    Provider.of<MainController>(context,listen:false).getEssentialServiceList();
    setState(() {});
  }

  void _setTypeOfDisaster(String value) async{
    Provider.of<MainController>(context,listen: false).newRequest.setDisaster(value);
    setState(() {});
  }

  void _setTypeOfEssentialService(String value) async{
    Provider.of<MainController>(context,listen: false).newRequest.setEssentialService(value);
    setState(() {});
  }

  void _setIsEmergency(bool? value) {
    Provider.of<MainController>(context, listen: false).newRequest.setIsEmergency(value!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Raise Request'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formNewRequest,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              DropdownOption(
                icon: const FaIcon(Icons.emergency),
                labelText: 'Disaster Type',
                defaultValue: Provider.of<MainController>(context, listen: true).newRequest.getDisaster,
                optionList: Provider.of<MainController>(context,listen: false).newRequest.getDisasterList,
                setValue: _setTypeOfDisaster,
              ),
              DropdownOption(
                icon: const FaIcon(Icons.help),
                labelText: 'Essential Service Type',
                defaultValue: Provider.of<MainController>(context, listen: true).newRequest.getEssentialService,
                optionList: Provider.of<MainController>(context,listen: false).newRequest.getEssentialServiceList,
                setValue: _setTypeOfEssentialService,
              ),
              CustomTextFormField(
                icon: const FaIcon(Icons.live_help),
                keyboardType: TextInputType.name,
                secureText: false,
                labelText: 'Request Description',
                saveUserInput: Provider.of<MainController>(context, listen: false).newRequest.setRequest,
              ),
              CustomCheckbox(
                icon: const FaIcon(Icons.emergency),
                text: 'Emergency',
                defaultValue: Provider.of<MainController>(context, listen: true).newRequest.getIsEmergency,
                onChanged: _setIsEmergency,
              ),
              PushReplacementButton(
                buttonText: 'Submit',
                onPressed: () async {
                  if (_formNewRequest.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('We are there for you')),
                    );
                    bool response = await Provider.of<MainController>(context, listen: false).userRequest();
                    if (response){
                      Provider.of<MainController>(context,listen: false).getHelpRequests();
                      Navigator.pop(context);
                    }
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
