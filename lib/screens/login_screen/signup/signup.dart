import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/core/const.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_cubit.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_state.dart';
import 'package:messanger_app/cubit/signup_cubit/sign_up_cubit.dart';
import 'package:messanger_app/cubit/signup_cubit/signup_state.dart';
import 'package:messanger_app/screens/login_screen/login/login_screen.dart';
import 'package:messanger_app/screens/widgets/botom_sheet_for_image.dart';
import 'package:messanger_app/screens/widgets/custom_buttom.dart';
import 'package:messanger_app/screens/widgets/custom_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController tEmail = TextEditingController();
  final TextEditingController tPassword = TextEditingController();
  final TextEditingController tName = TextEditingController();
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
                  create: (context) => SignUpCubit(),
                  child: BlocConsumer<SignUpCubit, SignupState>(
                    builder: (context, state) {
                      return Form(
                        key: foemKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //icon
                            titleSection(context),
                            //form
                            formTextFieldSection(),
                            //form buttom
                            BlocBuilder<PickerCubit, PickerState>(
                                builder: (context, state) {
                              return CustomButtom(
                                onTap: () {
                                  if (foemKey.currentState!.validate()) {
                                    BlocProvider.of<SignUpCubit>(context)
                                        .makeSignUpOperation(
                                      email: tEmail.text,
                                      password: tPassword.text,
                                      name: tName.text,
                                      context: context,
                                      imageLink:
                                          BlocProvider.of<PickerCubit>(context)
                                                      .myImage ==
                                                  null
                                              ? imageIfNull
                                              : BlocProvider.of<PickerCubit>(
                                                      context)
                                                  .imageLinkInFireBase!,
                                    );
                                  }
                                },
                                widget: state is SignupLoadingState
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              );
                            }),
                            //
                            const SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text('Already have Account ?  '),
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Login Now',
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
                    listener: (context, state) {
                      if (state is SignupSuccessState) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                  )),
            ),
          ),
        ),
      ),
    );
  }

  Column titleSection(context) {
    return Column(
      children: [
        BlocConsumer<PickerCubit, PickerState>(
          listener: (context, state) {
            if (state is PickProfilePhotoSuccess) {
              BlocProvider.of<PickerCubit>(context).uploadProfileImage();
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return const BottomSheetForImage();
                  },
                );
              },
              child: Stack(
                children: [
                  state is PickProfilePhotoLoaiding
                      ? const SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        )
                      : BlocProvider.of<PickerCubit>(context).myImage == null
                          ? const Icon(
                              Icons.person_pin,
                              size: 120,
                            )
                          : CircleAvatar(
                              radius: 53,
                              backgroundImage: FileImage(
                                BlocProvider.of<PickerCubit>(context).myImage!,
                              ),
                            ),
                  SizedBox(
                    height: 100,
                    width: 110,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        child: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 30,
        ),
        //welcom text
        const Text('After picking image please fill this sections'),
        const SizedBox(
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
            } else {}
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
          height: 20,
        ),
        CustomTextField(
          hintText: 'Re Password',
          security: true,
          controller: tPassword,
          validate: (value) {
            if (value!.isEmpty) {
              return 'you must enter password';
            }
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
          hintText: 'Name',
          security: false,
          controller: tName,
          validate: (value) {
            if (value!.isEmpty) {
              return 'you must enter Name';
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
