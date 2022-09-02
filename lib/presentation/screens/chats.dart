import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/components.dart';
import 'package:social_app/presentation/screens/chat_details_screen.dart';

import '../../data/models/social_user_model.dart';
import '../../domain/social_layout_cubit/social_cubit.dart';
import '../../domain/social_layout_cubit/social_state.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context, state) {
          var usersList = SocialCubit.get(context).socialUserModelList;
          return ConditionalBuilder(
              condition: usersList.isNotEmpty,
              builder: (context) => ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context , index) => buildChatItem(usersList[index],context),
                  separatorBuilder: (context , index) =>Container(height: 1,color: Colors.black,),
                  itemCount: usersList.length),
              fallback: (context) => const Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }

  Widget buildChatItem(SocialUserModel model,context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: (){
          navigateTo(context: context, navigatedScreen: ChatDetailScreen(socialUserModel: model,));
        },
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('${model.image}'),
              radius: 27,
            ),
            SizedBox(width: 15,),
            Text('${model.name}'),
          ],
        ),
      ),
    );
  }
}
