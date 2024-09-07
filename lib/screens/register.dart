import 'package:chat_app/constant.dart';
import 'package:chat_app/screens/chat-page.dart';
import 'package:chat_app/widgets/custom_botton.dart';
import 'package:chat_app/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

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
                      'REGISTER',
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
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id,
                            arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'week-password') {
                          showSnackBar(context, 'week password',
                              const TextStyle(color: Colors.red));
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'email already exists ',
                              const TextStyle(color: Colors.red));
                        }
                      } catch (e) {
                        showSnackBar(context, 'there was an error',
                            const TextStyle(color: Colors.red));
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                  titel: 'Register',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'I have an account',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        //بنعمل push عن طريق ال name
                        Navigator.pushNamed(context, 'Login');
                      },
                      child: const Text(
                        '   Login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
