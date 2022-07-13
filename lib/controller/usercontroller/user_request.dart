import 'package:manjhi/controller/util/const_uris.dart';
import 'package:manjhi/model/usermodel/user_model.dart';
import 'package:http/http.dart' as http;


class UserRequest {
  Future<int> userRegisterRequestAPI(User user) async {
    var userRequestResponse = await http.post(
      Uri.parse(userRegister),
      body: {
        'mobile_number': user.getMobileNumber,
        'name' : user.getName
      },
    );
    return userRequestResponse.statusCode;
  }

  Future<int> userAddressRequestAPI(User user) async {
    var userRequestResponse = await http.post(
      Uri.parse(userAddress),
      body: {
        'user': user.getMobileNumber,
        'address': user.getAddress,
        'area': user.getArea,
        'district': user.getDistrict,
        'state': user.getState,
        'country': user.getCountry,
      },
    );
    return userRequestResponse.statusCode;
  }

  Future<int> userFamilyRequestAPI(User user) async {
    var userRequestResponse = await http.post(
      Uri.parse(userFamily),
      body: {
        'user': user.getMobileNumber,
        'no_baby': user.getBaby.toString(),
        'no_children': user.getChild.toString(),
        'no_adult': user.getAdult.toString(),
        'no_senior': user.getSenior.toString(),
        'no_ph': user.getPh.toString(),
      },
    );
    return userRequestResponse.statusCode;
  }

}