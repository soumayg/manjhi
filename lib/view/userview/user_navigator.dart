import 'package:manjhi/controller/locationcontroller/location_controller.dart';
import 'package:manjhi/controller/usercontroller/user_controller.dart';
import 'package:manjhi/view/mainview/main_navigate.dart';
import 'package:manjhi/view/userview/user_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserNavigate extends StatelessWidget {
  const UserNavigate({Key? key}) : super(key: key);
  static String id = 'UserNavigate';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserContoller>(create: (context) => UserContoller()),
        ChangeNotifierProvider<LocationController>(create: (context) => LocationController()),
      ],
      child: MaterialApp(
        initialRoute: UserRegisterScreen.id,
        routes: {
          UserRegisterScreen.id: (context) => const UserRegisterScreen(),
          MainNavigate.id: (context) => const MainNavigate(),
        },
      ),
    );
  }
}
