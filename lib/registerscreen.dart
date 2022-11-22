import 'package:kavinie/register_controller.dart';
import 'package:kavinie/login_controller.dart';
import 'package:kavinie/login_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kavinie/login_screen.dart';
import 'package:kavinie/wapper.dart';

class RegisterScreen extends StatefulHookConsumerWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(LoginControllerProvider, ((previous, state) {
      if (state is LoginStateError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error),
        ));
      }
    }));

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              Container(
                width: 223,
                height: 215,
                 child: Image(image: AssetImage('assets/images/img.png')),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),

                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text(
                  '',
                ),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () {
                      ref
                          .read(RegisterControllerProvider.notifier)
                          .Register(emailController.text, passwordController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const  wapper()),
                      );

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,


                    ),



                  )),
              Row(
                children: <Widget>[
                  const Text(''),
                  TextButton(
                    child: const Text(
                      '',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                    },

                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
