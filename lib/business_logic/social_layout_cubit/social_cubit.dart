import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/presentation/screens/add_post.dart';
import 'package:social_app/presentation/screens/chats.dart';
import 'package:social_app/presentation/screens/feeds.dart';
import 'package:social_app/presentation/screens/settings.dart';
import 'package:social_app/presentation/screens/users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/models/social_user_model.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? socialUserModel;

  void getUsers() {
    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const AddPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<Widget> appBarTitles = [
    const Text('Home'),
    const Text('Chats'),
    const Text('Add post'),
    const Text('Users'),
    const Text('Settings')
  ];

  void changeBottomNav(int index, context) {
    if (index == 2) {
      emit(AddPostScreenState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  File? profileImage;
  File? coverImage;
  var picker = ImagePicker();

  Future<void> getImagePick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(GetPickedImageSuccessState());
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  Future<void> getCoverPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetPickedCoverSuccessState());
    } else {
      emit(GetPickedCoverErrorState());
    }
  }

  String profileImageUrl = '';
  String coverImageUrl = '';

  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        profileImageUrl = value;
        emit(UploadImageSuccessState());
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  void uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;
        emit(UploadCoverSuccessState());
      }).catchError((error) {
        emit(UploadCoverErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverErrorState());
    });
  }

  void updateAllUserData({
    required String phone,
    required String bio,
    required String name,
  }) {
    emit(UpdateUserDataLoadingState());
    if(coverImage!=null){
      uploadCoverImage();
    }else if(profileImage!=null) {
      uploadProfileImage();
    }else if(profileImage!=null && coverImage!=null) {

    }else{
      updateUserData(name: name, phone: phone, bio: bio);
    }
  }

  void updateUserData({
    required String phone,
    required String bio,
    required String name,
  }){
    SocialUserModel model = SocialUserModel(
        email: socialUserModel!.email,
        phone: phone,
        name: name,
        userId: socialUserModel!.userId,
        bio: bio,
        image: socialUserModel!.image,
        cover: socialUserModel!.cover);
    FirebaseFirestore.instance.collection('users').doc(userId).update(model.toMap()).then((value) {
      getUsers();
    }).catchError((error){
      emit(UpdateUserDataErrorState());
    });
  }
}
