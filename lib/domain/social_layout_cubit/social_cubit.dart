import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/domain/social_layout_cubit/social_state.dart';
import 'package:social_app/constants.dart';
import 'package:social_app/presentation/screens/add_post.dart';
import 'package:social_app/presentation/screens/chats.dart';
import 'package:social_app/presentation/screens/feeds.dart';
import 'package:social_app/presentation/screens/settings.dart';
import 'package:social_app/presentation/screens/users.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/models/post_creation_model.dart';
import '../../data/models/comment_model.dart';
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
          print(userId);
          socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString())); //edited here
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
     FeedsScreen(),
    const ChatsScreen(),
    AddPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<Widget> appBarTitles = [
    const Text('Home'),
    const Text('Chats'),
    const Text('Create post'),
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

  File? coverImage;

  Future<void> getCoverPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(GetPickedCoverSuccessState());
    } else {
      emit(GetPickedCoverErrorState());
    }
  }

  //uploading profile image
  void uploadProfileImage({
    required String phone,
    required String bio,
    required String name,
  }) {
    emit(UpdateUserDataLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(phone: phone, name: name, bio: bio, image: value);
        emit(UploadImageSuccessState());
      }).catchError((error) {
        emit(UploadImageErrorState());
      });
    }).catchError((error) {
      emit(UploadImageErrorState());
    });
  }

  //uploading cover image
  void uploadCoverImage({
    required String phone,
    required String bio,
    required String name,
  }) {
    emit(UpdateUserDataLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(phone: phone, name: name, bio: bio, cover: value);
        emit(UploadCoverSuccessState());
      }).catchError((error) {
        emit(UploadCoverErrorState());
      });
    }).catchError((error) {
      emit(UploadCoverErrorState());
    });
  }

  //updating user data
  void updateUserData({
    required String phone,
    required String bio,
    required String name,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
        email: socialUserModel!.email,
        phone: phone,
        name: name,
        userId: socialUserModel!.userId,
        bio: bio,
        image: image ?? socialUserModel!.image,
        cover: cover ?? socialUserModel!.cover);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update(model.toMap())
        .then((value) {
      getUsers();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  //Creating new post methods

  File? postImage;

  Future<void> getPostImagePick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(GetPickedPostImageSuccessState());
    } else {
      emit(GetPickedPostImageErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(RemovingPostImageState());
  }

  void uploadPostImage({
    required String text,
    required String dateTime,
  }) {
    emit(CreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, dateTime: dateTime, postImage: value);
      }).catchError((error) {
        emit(CreatePostSuccessState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState(error.toString()));
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(CreatePostLoadingState());
    CreatePostModel model = CreatePostModel(
        name: socialUserModel!.name,
        uId: socialUserModel!.userId,
        image: socialUserModel!.image,
        text: text,
        dateTime: dateTime,
        postImage: postImage ?? '');
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  List<CreatePostModel> posts = [];
  List<String> postsId = [];
  List<int> likesNumber = [];
  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
     for (var element in value.docs) {
       element.reference.collection('likes').get().then((value) {
         likesNumber.add(value.docs.length);
         postsId.add(element.id);
         posts.add(CreatePostModel.fromJson(element.data()));
         emit(FillingPostModelSuccessState());
       });
     }
     getCommentsNumber();
     emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }



  void postLikes(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel!.userId)
        .set({'like': true}).then((value) {
      emit(PostLikeSuccessState());
    }).catchError((error) {
      emit(PostLikeErrorState(error.toString()));
    });
  }




  void createComment({
    required String commentText,
    required String postId,
  }){
    emit(CreateCommentLoadingState());
    CommentModel  commentModel = CommentModel(
      name: socialUserModel!.name,
      image: socialUserModel!.image,
      comment: commentText,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .add(commentModel.toMap())
        .then((value) {
          emit(CreateCommentSuccessState());
    })
        .catchError((error){
      emit(CreateCommentErrorState(error.toString()));

    });
}

  List<CommentModel> comments = [];
  List<int> commentsNumber = [];
void getCommentsNumber(){
  FirebaseFirestore.instance.collection('posts').get().then((value) {
    for (var element in value.docs) {
      element.reference.collection('comments').get().then((value) {
        commentsNumber.add(value.docs.length);
        emit(PostCommentNumbersSuccessState());
      });
    }
    print(commentsNumber.length);
  }).catchError((error) {
    emit(PostCommentNumbersErrorState(error.toString()));
  });
}

void getComments(){

  FirebaseFirestore.instance.collection('posts').get().then((value) {
    for (var element in value.docs) {
      element.reference.collection('comments').get().then((value) {
        for (var element in value.docs){
          comments.add(CommentModel.fromJson(element.data()));
        }
        emit(PostCommentSuccessState());

      });
    }
  }).catchError((error){
    emit(PostCommentErrorState(error.toString()));

  });
}


List<SocialUserModel> socialUserModelList = [];
  void getUsersChat() {
    emit(GetChatUsersLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        socialUserModelList.add(SocialUserModel.fromJson(element.data()));
      });
      emit(GetChatUsersSuccessState());
    }).catchError((error) {
      emit(GetChatUsersErrorState(error.toString()));
    });
  }

}
