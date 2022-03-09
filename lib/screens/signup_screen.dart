import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/login_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // print("selected");
    setState(() {
      _image = im;
      // print(_image);
    });
  }
 //575621
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

        setState(() {
          _isLoading = true;
        });

    if(res != 'success'){
        showSnackBar(res, context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResposiveLayout(mobileScreenLayout: MobileScreen(), webScreenLayout: WebScreen())));
    }
  }

   navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              // height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.symmetric(
            horizontal: 32,
                  ),
                  // width: double.infinity,
                  child: Column(
                    mainAxisSize : MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Container(),
                              flex: 2,
                            ),
                            SvgPicture.asset("assets/ic_instagram.svg",
                  color: primaryColor, height: 64),
                            const SizedBox(
                              height: 44,
                            ),
                            Stack(children: [
                              _image != null
                    ? CircleAvatar(
                        radius: 64, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                      ),
                              Positioned(
                    bottom: -10,
                    right: -5,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo)))
                            ]),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldInput(
                  hintText: "Enter your username",
                  textEditingController: _usernameController,
                  textInputType: TextInputType.text),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldInput(
                  hintText: "Enter your email",
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldInput(
                              hintText: "Enter your password",
                              textEditingController: _passwordController,
                              textInputType: TextInputType.text,
                              isPass: true,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFieldInput(
                              hintText: "Enter your bio",
                              textEditingController: _bioController,
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            InkWell(
                              onTap: signUpUser,
                              child: Container(
                  child: _isLoading ? const Center(child : CircularProgressIndicator(color: primaryColor,) ) : const Text("Sign up"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: blueColor),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Flexible(
                              child: Container(),
                              flex: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                  Container(
                      child: const Text("have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8)),
                  InkWell(
                    onTap: navigateToLogin,
                    child: Container(
                        child: const Text(" Sign in",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        padding: const EdgeInsets.symmetric(vertical: 8)),
                  )
                              ],
                            )
                          ],
                       ),
                ),
          )),
    );
  }
}
