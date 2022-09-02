import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/models/message_model.dart';
import 'package:social_app/data/models/social_user_model.dart';
import 'package:social_app/domain/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/style/icon_broken.dart';
import '../../domain/social_layout_cubit/social_cubit.dart';

class ChatDetailScreen extends StatelessWidget {
    ChatDetailScreen({Key? key, required this.socialUserModel}) : super(key: key);
   final SocialUserModel socialUserModel;
   var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (BuildContext context){
          SocialCubit.get(context).getMessages(receiverId: socialUserModel.userId!);
          return BlocConsumer<SocialCubit, SocialState>(
              builder: (context , state) {
                var messagesList = SocialCubit.get(context).messagesList;
                return Scaffold(
                  appBar: AppBar(
                    titleSpacing: 0,
                    backgroundColor: Colors.white,
                    elevation: 1,
                    foregroundColor: Colors.black,
                    title: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage('${socialUserModel.image}'),
                            radius: 23,
                          ),
                        ),
                        const SizedBox(width: 7,),
                        Text('${socialUserModel.name}'),
                      ],
                    ),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ConditionalBuilder(
                                condition: messagesList.isNotEmpty,
                                builder: (context) => ListView.separated(
                                    itemBuilder: (context, index){
                                      if(messagesList[index].senderId != SocialCubit.get(context).socialUserModel!.userId) {
                                        return buildMessageItem(messagesList[index]);
                                      }
                                      return buildMyMessageItem(messagesList[index]);
                                    },
                                    separatorBuilder: (context, index) => SizedBox(height: 10,),
                                    itemCount: messagesList.length),
                                fallback: (context) => const Center(child: CircularProgressIndicator(),))
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: Colors.grey[300]!
                              )
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextFormField(
                                    controller: messageController,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Write message ...'
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  color:Colors.blue,
                                  child: IconButton(
                                      onPressed: (){
                                        SocialCubit.get(context).sendMessage(
                                            receiverId: socialUserModel.userId!,
                                            dateTime: DateTime.now().toString(),
                                            text: messageController.text
                                        );
                                        messageController.text = '';
                                      },
                                      icon: const Icon(IconBroken.Send,color: Colors.white,)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              listener: (context , state) {});
        }
    );
  }

  Widget buildMyMessageItem(MessageModel model){
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.blue[300],
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            )
        ),
        child:  Text( model.messageText!),
      ),
    );
  }

  Widget buildMessageItem(MessageModel model ){
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )
        ),
        child:  Text(model.messageText!),
      ),
    );
  }
}
