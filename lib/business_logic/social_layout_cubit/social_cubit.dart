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
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/models/post_creation_model.dart';
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
      socialUserModel = SocialUserModel.fromJson(value.data()!);
      emit(GetUserSuccessState());
    }).catchError((error) {
      emit(GetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
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
        emit(CreatePostErrorState());
      });
    }).catchError((error) {
      emit(CreatePostErrorState());
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


  void getPosts() {
    emit(GetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        posts.add(CreatePostModel.fromJson(element.data()));
      }
      emit(GetPostsSuccessState());
    }).catchError((error) {
      emit(GetPostsErrorState(error.toString()));
    });
  }

  void postLikes(String postId){
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(postId)
        .collection('likes')
        .doc(socialUserModel!.userId)
        .set(
        {'like': true})
        .then((value) {})
        .catchError((error){});
  }
}
