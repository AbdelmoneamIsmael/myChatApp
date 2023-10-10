import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messanger_app/cubit/picker_cubit/image_picker_state.dart';

class PickerCubit extends Cubit<PickerState> {
  PickerCubit() : super(PickProfilePhotoIntialState());

  File? myImage;
  void closed() {
    emit(BottomSheetClosed());
  }

  //PICK IMAGE
  Future<void> addPhoto({required bool isCamera}) async {
    emit(PickProfilePhotoLoaiding());
    try {
      var selectedImage = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery);
      if (selectedImage == null) return;
      var temporaryImage = File(selectedImage.path);

      myImage = temporaryImage;
      print('this is the image $myImage');
      emit(PickProfilePhotoSuccess());
    } on PlatformException catch (e) {
      print('failed to pick image $e');
      emit(PickProfilePhotoFailed());
    }
  }

  //upload image to firebase
  String? imageLinkInFireBase;
  void uploadProfileImage() {
    emit(UploadeProfilePhotoLoaiding());
    FirebaseStorage.instance
        .ref()
        .child('Profile/${Uri.file(myImage!.path).pathSegments.last}')
        .putFile(myImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        emit(UploadeProfilePhotoSuccess());
        imageLinkInFireBase = value.toString();
      }).catchError((error) {});
    }).catchError((error) {
      print(error.toString());
      emit(UploadeProfilePhotoFailed());
    });
  }
}
