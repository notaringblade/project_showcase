import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_showcase/models/user_model.dart';

class Auth {
  Future signUp(BuildContext context, String email, String username,
      String password) async {
    showLoading(context);
    if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
      try {
        Navigator.pop(context);

        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.user!.uid)
            .set(UserModel(username: username, uid: user.user!.uid, posts: [])
                .toMap());
      } catch (e) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return Center(
                child: Text(e.toString()),
              );
            },
          );
        } else {
          // Navigator.pop(context);
        }
      }
    } else {
      Navigator.pop(context);
    }
  }

  void showLoading(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future signIn(BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Enter Required Information', Colors.red),
        );
      }
      if (context.mounted) {
        Navigator.pop(context);
      }
      // Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Email', Colors.red),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Password', Colors.red),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBarMessage('Please Check Your Email And Password', Colors.red),
        );
      }
      Navigator.pop(context);
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  SnackBar snackBarMessage(String s, Color color) {
    return SnackBar(
      duration: const Duration(seconds: 2),
      backgroundColor: color,
      content: Text(
        s,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
