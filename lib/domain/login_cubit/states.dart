abstract class SocialLoginStates {}
class SocialLoginInitialState extends SocialLoginStates{}
class SocialLoginLoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{
 final dynamic value;

  SocialLoginSuccessState(this.value);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialChangePasswordVisibilityState extends SocialLoginStates{}

class NavigatedDone extends SocialLoginStates{}




