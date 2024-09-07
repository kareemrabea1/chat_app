import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/chat-page.dart';
import 'package:chat_app/screens/register.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 100),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Image.network(
                    height: 100,
                    width: 100,
                    'https://dpsbalotra.org/wp-content/uploads/2021/07/new-admission.png'),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacific',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormTextField(
                  onChange: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  obscureText: true,
                  onChange: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomBotton(
                  onTap: () async {
                    FirebaseAuth.instance;
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});

                      try {
                        await loginUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'user-not-found',
                              const TextStyle(color: Colors.red));
                        } else if (e.code == 'wrong password') {
                          showSnackBar(context, 'wrong password',
                              const TextStyle(color: Colors.red));
                        }
                      } catch (e) {
                        print(e);
                        showSnackBar(context, 'there was an error',
                            const TextStyle(color: Colors.red));
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  titel: 'Login',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        //بنعمل push عن طريق ال name
                        Navigator.pushNamed(context, 'Register');
                      },
                      child: const Text(
                        '  Register',
                        style: TextStyle(color: Color(0xffC7EDE6)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
