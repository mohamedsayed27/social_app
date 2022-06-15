import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/login_cubit/states.dart';


class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());


  static SocialLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      print(value.user!.email);
      emit(SocialLoginSuccessState());
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }
  Icon suffix = const Icon(Icons.visibility);
  bool isVisible = true;
  void passwordVisible(){
    isVisible = !isVisible;
    suffix = Icon(isVisible ? Icons.visibility:Icons.visibility_off);
    emit(SocialChangePasswordVisibilityState());
  }

  // void trying(context){
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //           const RegisterScreen())
  //
  //   );
  //   emit(NavigatedDone());
  // }
}
