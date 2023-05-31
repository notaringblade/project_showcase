import 'package:flutter/material.dart';
import 'package:project_showcase/widgets/custom_button.dart';
import 'package:project_showcase/widgets/text_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key, required this.changeAuthState}) : super(key: key);
  final Function changeAuthState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
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
                  textController: TextEditingController(),
                  hintText: 'username'),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  textController: TextEditingController(), hintText: 'email'),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                textController: TextEditingController(),
                hintText: 'password',
                obscure: true,
              ),
              SizedBox(
                height: 50,
              ),
              CustomButton(buttonText: 'Sign up'),
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
                      changeAuthState();
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
    );
  }
}
