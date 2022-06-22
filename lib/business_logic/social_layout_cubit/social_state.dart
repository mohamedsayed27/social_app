abstract class SocialState {}
class SocialInitial extends SocialState {}
class GetUserLoadingState extends SocialState{}
class GetUserSuccessState extends SocialState{}
class GetUserErrorState extends SocialState{
  final String error;
  GetUserErrorState(this.error);
}
class ChangeBottomNavBarState extends SocialState{}
class AddPostScreenState extends SocialState{}

class GetPickedImageSuccessState extends SocialState{}
class GetPickedImageErrorState extends SocialState{}
class GetPickedCoverSuccessState extends SocialState{}
class GetPickedCoverErrorState extends SocialState{}