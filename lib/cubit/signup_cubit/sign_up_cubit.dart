import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messanger_app/cubit/signup_cubit/signup_state.dart';
import 'package:messanger_app/screens/login_screen/login/login_screen.dart';

class SignUpCubit extends Cubit<SignupState> {
  SignUpCubit() : super(SignupInitialState());
  File? myImage;
  //sign up method
  void makeSignUpOperation(
      {required String email,
      required String password,
      required String name,
      required String imageLink,
      required BuildContext context}) {
    emit(SignupLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set({
        'uid': value.user!.uid,
        'email': value.user!.email,
        'password': password,
        'name': name,
        'image': imageLink,
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email Created !'),
          ),
        );
        emit(SignupSuccessState());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      }).catchError((e) {
        emit(SignupFailState());
      });
    }).catchError((e) {
      emit(SignupFailState());
    });
  }
}
