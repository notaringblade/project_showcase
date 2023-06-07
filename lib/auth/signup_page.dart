import 'package:flutter/material.dart';
import 'package:project_showcase/services/auth_service.dart';
import 'package:project_showcase/widgets/custom_button.dart';
import 'package:project_showcase/widgets/text_widget.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key, required this.changeAuthState}) : super(key: key);
  final Function changeAuthState;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Auth auth = Auth();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.file_copy_outlined,
                  size: 128,
                ),
                SizedBox(
                  height: 70,
                ),
                CustomTextField(
                    textController: usernameController, hintText: 'username'),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    textController: emailController, hintText: 'email'),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  textController: passwordContoller,
                  hintText: 'password',
                  obscure: true,
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                    onTap: () {
                      auth.signUp(context, emailController.text,
                          usernameController.text, passwordContoller.text);
                    },
                    child: CustomButton(buttonText: 'Sign up')),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.changeAuthState();
                      },
                      child: Text(
                        " Sign in",
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.cyan,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
