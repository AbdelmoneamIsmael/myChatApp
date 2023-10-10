import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/cubit/login_cubit/login_cubit.dart';
import 'package:messanger_app/cubit/login_cubit/login_state.dart';
import 'package:messanger_app/screens/login_screen/signup/signup.dart';
import 'package:messanger_app/screens/widgets/custom_buttom.dart';
import 'package:messanger_app/screens/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tPassword = TextEditingController();
  final GlobalKey<FormState> foemKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocProvider(
                create: (context) => LoginCubit(),
                child: BlocConsumer<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Form(
                      key: foemKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //icon
                          titleSection(),
                          //form
                          formTextFieldSection(),
                          //form buttom
                          CustomButtom(
                            onTap: () {
                              if (foemKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context)
                                    .makeLoginOperation(
                                        name: tEmail.text,
                                        password: tPassword.text,
                                        context: context);
                              }
                            },
                            widget: state is LoginLoadingState
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                          //
                          const SizedBox(
                            height: 30,
                          ),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Dont have Account ?  '),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Register Now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  listener: (context, state) {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column titleSection() {
    return const Column(
      children: [
        Icon(
          Icons.message,
          size: 120,
        ),
        SizedBox(
          height: 30,
        ),
        //welcom text
        Text('Welcome back you have been missed !'),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column formTextFieldSection() {
    return Column(
      children: [
        CustomTextField(
          hintText: 'Email',
          controller: tEmail,
          validate: (value) {
            if (value!.isEmpty) {
              return 'you must enter Email';
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Password',
          security: true,
          controller: tPassword,
          validate: (value) {
            if (value!.isEmpty) {
              return 'you must enter password';
            }
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
