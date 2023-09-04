import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async{
    Uint8List im = await myImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!
    );
    setState(() {
      _isLoading = false;
    });

    if(res != 'success') {
      showSnackBar(res, context);
    } else if(res == "success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout()
         )
        )
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
              const SizedBox(height: 24),

              // Circular widget to show image
              Stack(
                 children: [
                   _image != null ? CircleAvatar(
                     radius: 64,
                     backgroundImage: MemoryImage(_image!)
                   )
                   : const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                        'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'
                    ),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                            Icons.add_a_photo,
                          color: primaryColor,
                        ),
                      )
                  )
                ],
              ),
              const SizedBox(height: 24),

              // Text input field for username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Create a username',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),

              // Text input field for email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),

              // Text input field for bio
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your Bio',
                textInputType: TextInputType.text,
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
                onTap: signUpUser,
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
                  child: _isLoading ?  const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      )
                  ) : const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(flex: 2, child: Container()),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: const Text("Already have an account ?"),
                  ),
                  const SizedBox(width: 10,),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text(
                        "Login",
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
