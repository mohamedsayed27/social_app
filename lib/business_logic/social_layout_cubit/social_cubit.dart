import 'package:bloc/bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());
}
