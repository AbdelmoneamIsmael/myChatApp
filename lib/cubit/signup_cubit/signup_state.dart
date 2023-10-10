// import 'package:messanger_app/model/user_model.dart';

abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupSuccessState extends SignupState {
  // final UserInformation userInformation;
  // LoginSuccessState(this.userInformation);
}

class SignupLoadingState extends SignupState {}

class SignupFailState extends SignupState {}
