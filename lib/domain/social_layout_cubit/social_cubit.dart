import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/data/models/message_model.dart';
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

  int currentIndex = 0;

  File? profileImage;

  File? coverImage;

  File? postImage;

  List<CreatePostModel> posts = [];

  List<String> postsId = [];

  List<int> likesNumber = [];

  List<CommentModel> comments = [];

  List<int> commentsNumber = [];

  List<SocialUserModel> socialUserModelList = [];

  List<MessageModel> messagesList = [];

  var picker = ImagePicker();

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
      emit(GetUserErrorState(error.toString())); //edited here
    });
  }

  void changeBottomNav(int index, context) {
    if (index == 1) getUsersChat();
    if (index == 2) {
      emit(AddPostScreenState());
    } else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

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
  }) async {
    emit(CreatePostLoadingState());
    TaskSnapshot snap = await FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!);
    try {
      String imageUrl = await snap.ref.getDownloadURL();
      createPost(text: text, dateTime: dateTime, postImage: imageUrl);
      emit(CreatePostSuccessState());
    } catch (e) {
      emit(CreatePostErrorState(e.toString()));
    }
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


  void getPosts() async {
    posts = [];
    likesNumber = [];
    comments = [];
    commentsNumber = [];
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) async {
      for (var element in event.docs) {
        QuerySnapshot<Map<String, dynamic>> likeSnap =
            await element.reference.collection('likes').get();
        QuerySnapshot<Map<String, dynamic>> commentSnap =
            await element.reference.collection('comments').get();
        posts.add(CreatePostModel.fromJson(element.data()));
        try {
          likesNumber.add(likeSnap.docs.length);
          postsId.add(element.id);
          emit(GetPostsSuccessState());
        } catch (error) {
          emit(GetPostsErrorState(error.toString()));
        }
        try {
          commentsNumber.add(commentSnap.docs.length);
          emit(GetCommentsNumberSuccessState());
        } catch (error) {
          emit(GetCommentsNumberErrorState(error.toString()));
        }
      }
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
  }) {
    emit(CreateCommentLoadingState());
    CommentModel commentModel = CommentModel(
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
    }).catchError((error) {
      emit(CreateCommentErrorState(error.toString()));
    });
  }


  void getUsersChat() {
    if (socialUserModelList.isEmpty) {
      emit(GetChatUsersLoadingState());
      FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['UId'] != socialUserModel!.userId) {
            socialUserModelList.add(SocialUserModel.fromJson(element.data()));
          }
        }
        emit(GetChatUsersSuccessState());
      }).catchError((error) {
        emit(GetChatUsersErrorState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
        receiverId: receiverId,
        messageText: text,
        senderId: socialUserModel!.userId,
        dateTime: dateTime);
    //sender chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError(error.toString()));
    });

    //receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(socialUserModel!.userId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessageSuccess());
    }).catchError((error) {
      emit(SendMessageError(error.toString()));
    });
  }


  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(socialUserModel!.userId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messagesList = [];
      for (var element in event.docs) {
        messagesList.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessageSuccess());
    });
  }
}
