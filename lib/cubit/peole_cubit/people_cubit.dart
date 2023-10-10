import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messanger_app/core/const.dart';
import 'package:messanger_app/cubit/peole_cubit/people_state.dart';
import 'package:messanger_app/model/user_model.dart';

class PeopleScreenCubit extends Cubit<PeopleScreenState> {
  PeopleScreenCubit() : super(PeopleScreenInitialState());
  int numberPeople = 0;
  List<UserInformation> usersInChatApp = [];
  String currentName = '';
  String profileImageLink = '';

  void getAllUsersInApp() async {
    emit(PeopleScreenLoadingState());
    try {
      var value = await FirebaseFirestore.instance.collection('Users').get();
      //get size
      numberPeople = value.size - 1;
      //get every person
      value.docs.forEach((element) {
        if (element['uid'] != token) {
          usersInChatApp.add(
            UserInformation(
                uid: element['uid'],
                email: element['email'],
                password: element['password'],
                image: element['image'],
                name: element['name']),
          );
        } else {
          currentName = element['name'];
          profileImageLink = element['image'];
        }
      });

      emit(PeopleScreenSuccessState());
    } catch (e) {
      emit(PeopleScreenFailState());
    }
  }
}
