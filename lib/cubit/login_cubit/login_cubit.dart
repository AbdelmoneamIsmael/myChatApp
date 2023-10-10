import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/core/const.dart';
import 'package:messanger_app/cubit/login_cubit/login_state.dart';
import 'package:messanger_app/screens/chat_Screen/users_of_chat/people.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void makeLoginOperation(
      {required String name,
      required String password,
      required BuildContext context}) async {
    emit(LoginLoadingState());
    try {
      var value = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: name, password: password);
      emit(
        LoginSuccessState(),
      );
      token = value.user!.uid;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PeopleChat(),
        ),
      );
    } catch (e) {
      emit(LoginFailState());
    }
  }
}
