import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3_provider/responsive_layout.dart';
import 'package:flutter_rest_api_3_provider/screens/Login/components/body/login_screen_desktop.dart';
import 'package:flutter_rest_api_3_provider/screens/Login/components/body/login_screen.dart';

class LoginResponsive extends StatelessWidget {
  const LoginResponsive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: LoginPage(),
      desktop: LoginDesktop(),
    );
  }
}
