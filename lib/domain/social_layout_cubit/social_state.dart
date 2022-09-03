
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

class UpdateUserDataLoadingState extends SocialState{}
class UpdateUserDataErrorState extends SocialState{}

class UploadImageSuccessState extends SocialState{}
class UploadImageErrorState extends SocialState{}
class UploadCoverSuccessState extends SocialState{}
class UploadCoverErrorState extends SocialState{}



class CreatePostLoadingState extends SocialState{}
class CreatePostSuccessState extends SocialState{}
class CreatePostErrorState extends SocialState{
  final String error;

  CreatePostErrorState(this.error);
}

class GetPickedPostImageSuccessState extends SocialState{}
class GetPickedPostImageErrorState extends SocialState{}


class RemovingPostImageState extends SocialState{}


class GetPostsLoadingState extends SocialState{}
class GetPostsSuccessState extends SocialState{}

class GetPostsErrorState extends SocialState{
  final String error;
  GetPostsErrorState(this.error);
}

class GetChatUsersLoadingState extends SocialState{}
class GetChatUsersSuccessState extends SocialState{}
class GetChatUsersErrorState extends SocialState{
  final String error;
  GetChatUsersErrorState(this.error);
}

class PostLikeSuccessState extends SocialState{}
class PostLikeErrorState extends SocialState{
  final String error;
  PostLikeErrorState(this.error);
}

class GetCommentsDataSuccessState extends SocialState{}
class GetCommentsDataErrorState extends SocialState{
  final String error;
  GetCommentsDataErrorState(this.error);
}

class GetCommentsNumberSuccessState extends SocialState{}
class GetCommentsNumberErrorState extends SocialState{
  final String error;
  GetCommentsNumberErrorState(this.error);
}


class CreateCommentLoadingState extends SocialState{}
class CreateCommentSuccessState extends SocialState{}
class CreateCommentErrorState extends SocialState{
  final String error;

  CreateCommentErrorState(this.error);
}


class SendMessageSuccess extends SocialState{}
class SendMessageError extends SocialState{
  final String error;

  SendMessageError(this.error);
}
class GetMessageSuccess extends SocialState{}
