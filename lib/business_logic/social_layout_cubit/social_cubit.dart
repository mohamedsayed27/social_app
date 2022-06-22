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

import '../../data/models/social_user_model.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);

    SocialUserModel? socialUserModel;
  void getUsers(){
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
  List<Widget> screens =[
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
   void changeBottomNav(int index,context){

     if(index == 2){
       emit(AddPostScreenState());
     }else{
       currentIndex = index;
       emit(ChangeBottomNavBarState());
     }

   }


   File? profileImage;
   var picker = ImagePicker();

   Future<void> getImagePick()async {
     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
     if(pickedFile != null){
       profileImage = File(pickedFile.path);
       emit(GetPickedImageSuccessState());
     }else{
       print('no image picked');
       emit(GetPickedImageErrorState());
     }
   }

}
