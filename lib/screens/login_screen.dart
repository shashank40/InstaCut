import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:InstaCut/resources/auth_methods.dart';
import 'package:InstaCut/responsive/mobile_screen_layout.dart';
import 'package:InstaCut/responsive/responsive_layout.dart';
import 'package:InstaCut/responsive/web_screen_layout.dart';
import 'package:InstaCut/screens/signup_screen.dart';
import 'package:InstaCut/utils/colors.dart';
import 'package:InstaCut/utils/global_variable.dart';
import 'package:InstaCut/utils/utils.dart';
import 'package:InstaCut/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    /// as soon as widget go off, dispose
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        /// safe area
        child: Container(
          /// conatiner to se padding
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  // from both sides horizontaly
                  horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,

          /// full width of device
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            /// to centre all children in rowise
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              TextFieldInput(
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
                textEditingController: _emailController,
              ),

              /// email's textbox
              const SizedBox(
                height: 24,
              ), //// b/w textsboxes
              TextFieldInput(
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                textEditingController: _passwordController,
                isPass: true,
              ),

              /// password
              const SizedBox(
                height: 24,
              ),
              InkWell(
                child: Container(
                  child: !_isLoading
                      ? const Text(
                          'Log in',
                        )
                      : const CircularProgressIndicator(
                          color: primaryColor,
                        ),
                  width: double.infinity,

                  /// max value
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),

                  /// paddind in text
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      /// shaped as circular
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    color: blueColor, //// color is in ours color folder
                  ),
                ),
                onTap: loginUser,
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                /// down we need 2 diff texts but same row, diff fonts
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Dont have an account?',
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    //// when we click it detects
                    onTap: () => Navigator.of(context).push(
                      /// click so we go to signup screen
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    ),
                    child: Container(
                      child: const Text(
                        ' Signup.',
                        style: TextStyle(
                          //// diff texxt style
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
