import 'package:flutter/material.dart';
import 'package:flutter_rest_api_3_provider/Provider/auth_provider.dart';
import 'package:flutter_rest_api_3_provider/responsive_layout.dart';
import 'package:flutter_rest_api_3_provider/screens/register_screen.dart';
import 'package:flutter_rest_api_3_provider/utility/routes.dart';
import 'package:flutter_rest_api_3_provider/utility/snack_message.dart';
import 'package:flutter_rest_api_3_provider/widgets/button.dart';
import 'package:flutter_rest_api_3_provider/widgets/text_field.dart';
import 'package:provider/provider.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: Responsive.isDesktop(context) ? 2 : 1,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        customTextField(
                          title: 'Email',
                          controller: _email,
                          hint: 'Enterr your valid email address',
                        ),
                        customTextField(
                            title: 'Password',
                            controller: _password,
                            hint: 'Enter your password'),
                        Consumer<AuthenticationProvider>(
                            builder: (context, auth, child) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (auth.resMessage != '') {
                              showMessage(
                                  message: auth.resMessage, context: context);
                              auth.clear();
                            }
                          });
                          return customButton(
                              text: 'Login',
                              tap: () {
                                if (_email.text.isEmpty ||
                                    _password.text.isEmpty) {
                                  showMessage(
                                      message: "All fields are required",
                                      context: context);
                                } else {
                                  auth.loginUser(
                                      context: context,
                                      email: _email.text.trim(),
                                      password: _password.text.trim());
                                }
                              },
                              context: context,
                              status: auth.isLoading);
                        }),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            PageNavigator(ctx: context)
                                .nextPage(page: const RegisterPage());
                          },
                          child: const Text('Register '),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
