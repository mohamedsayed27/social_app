import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/social_layout_cubit/social_cubit.dart';
import '../../domain/social_layout_cubit/social_state.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context, state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context , index) => buildChatItem(),
              separatorBuilder: (context , index) =>Container(height: 1,color: Colors.black,),
              itemCount: 30);
        },
        listener: (context, state) {});
  }

  Widget buildChatItem(){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://firebasestorage.googleapis.com/v0/b/social-app-2735e.appspot.com/o/users%2Fimage_picker7893180471670214747.jpg?alt=media&token=74b5c580-36c2-4a90-8907-cd753f1a841b'),
            radius: 27,
          ),
          SizedBox(width: 15,),
          Text('Mohamed Sayed'),
        ],
      ),
    );
  }
}
