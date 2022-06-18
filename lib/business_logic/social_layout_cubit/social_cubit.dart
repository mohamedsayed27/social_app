import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/constants.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
  static SocialCubit get(context) => BlocProvider.of(context);


  void getUsers(){
    emit(GetUserLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value) {
          print(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error));
    });
  }
}
