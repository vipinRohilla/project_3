import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_flutter/resources/auth_methods.dart';
import 'package:instagram_flutter/responsive/mobile_screen_layout.dart';
import 'package:instagram_flutter/responsive/responsive_layout.dart';
import 'package:instagram_flutter/responsive/web_screen_layout.dart';
import 'package:instagram_flutter/screens/signup_screen.dart';
import 'package:instagram_flutter/utils/colors.dart';
import 'package:instagram_flutter/utils/utils.dart';
import 'package:instagram_flutter/widgets/text_field_input.dart';

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
  }

  void loginUser() async{
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(email: _emailController.text, password: _passwordController.text);

    if(res == "success"){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResposiveLayout(mobileScreenLayout: MobileScreen(), webScreenLayout: WebScreen())));
    }
    else{
      showSnackBar(res, context);
    }
    setState(() {
        _isLoading = false;
      });
  }

  navigateToSignUp(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding : const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize : MainAxisSize.min,
              mainAxisAlignment : MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                SvgPicture.asset("assets/ic_instagram.svg",
             color: primaryColor, height: 64),
                const SizedBox(
                  height: 64,
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
                  textInputType: TextInputType.emailAddress,
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: loginUser,
                  child: Container(
             child: _isLoading ? const Center(child: CircularProgressIndicator(color: primaryColor,),) :  const Text("Log in"),
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
               child: const Text("Don't have an account?"),
               padding: const EdgeInsets.symmetric(vertical:8)
             ),
             InkWell(
               onTap : navigateToSignUp,
               child: Container(
                 child: const Text(" Sign up", style: TextStyle(fontWeight: FontWeight.bold)),
                 padding: const EdgeInsets.symmetric(vertical:8)
               ),
             )
                  ],
                )
              ],
             ),
          ),
          )
          // ),
    );
  }
}
