import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/social_user_model.dart';
import 'RegStates.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());


  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({
    required String email,
    required String password,
    required String phone ,
    required String name
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      userCreate(
          email: email,
          phone: phone,
          name: name,
          uId: value.user!.uid);
    }).catchError((error){
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String phone ,
    required String name,
    required String uId,

  }){

    SocialUserModel model = SocialUserModel(
      email: email,
      phone: phone,
      name: name,
      userId: uId
    );
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {
      emit(SocialCreateSuccessState());
    }).catchError((error){
      emit(SocialCreateErrorState(error.toString()));

    });
  }
  Icon suffix = const Icon(Icons.visibility);
  bool isVisible = true;
  void passwordVisible(){
    isVisible = !isVisible;
    suffix = Icon(isVisible ? Icons.visibility : Icons.visibility_off );
    emit(SocialChangePasswordVisibilityState());
  }
}