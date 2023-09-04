import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text,
        password: _passwordController.text
    );
    setState(() {
      _isLoading = false;
    });

    if(res != "success") {
      showSnackBar(res, context);
    }
    if(res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()
          )
        )
      );
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(flex: 2, child: Container()),
              // SVG Image
              SvgPicture.asset('assets/ic_instagram.svg', color: primaryColor, height: 64,),
              const SizedBox(height: 64),

              // Text input field for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Text input field for password
              TextFieldInput(
                textEditingController: _passwordController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),

              // Sign In/Login button
              InkWell(
                onTap: loginUser,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4)
                    )
                  )),
                  child: _isLoading ? const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ) : const Text('Log In'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Don't have an account ?"),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                          "Sign Up",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
