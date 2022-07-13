import 'package:manjhi/controller/maincontroller/main_controller.dart';
import 'package:manjhi/view/mainview/home_screen.dart';
import 'package:manjhi/view/mainview/new_request_screen.dart';
import 'package:manjhi/view/userview/user_navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainNavigate extends StatelessWidget {
  const MainNavigate({Key? key}) : super(key: key);
  static String id = 'MainNavigate';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainController(),
      child: MaterialApp(
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (context) => const HomeScreen(),
          NewRequestScreen.id: (context) => const NewRequestScreen(),
          UserNavigate.id: (context) => const UserNavigate(),
        },
      ),
    );
  }
}
