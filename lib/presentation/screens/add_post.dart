import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/domain/social_layout_cubit/social_cubit.dart';
import 'package:social_app/domain/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

import '../components.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          var now = DateTime.now();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(
                appBarTitleWidget: cubit.appBarTitles[2],
                leading: IconButton(
                    padding: EdgeInsetsDirectional.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(IconBroken.Arrow___Left_2)),
                actions: [
                  TextButton(
                      onPressed: () {
                        if(cubit.postImage == null){
                          cubit.createPost(text: textController.text, dateTime: now.toString());
                        }else{
                          cubit.uploadPostImage(text: textController.text, dateTime: now.toString());
                        }
                        textController.text = '';
                      },
                      child: const Text('POST')
                  ),
                  const SizedBox(
                    width: 5,
                  )
                ]),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if(state is CreatePostLoadingState)
                    const LinearProgressIndicator(),
                  if(state is CreatePostLoadingState)
                    const SizedBox(height: 10,),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/02/78/26/1000_F_302782694_VftvTDVoDT6kYW3lXTqvp8bmH3inmpT8.jpg'),
                        radius: 27,
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Anyone Here',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,height: 1.3)),
                            Text('27 May 2022',style: TextStyle(fontSize: 12,color: Colors.grey,height: 1.3))
                          ],
                        ),
                      ),

                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      decoration: const InputDecoration(
                          hintText: 'Write what you want ....',
                          border: InputBorder.none
                      ),

                    ),
                  ),
                  if(cubit.postImage != null)Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children:[
                        Container(
                          height: 175,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                              ),
                              image: DecorationImage(
                                  image: FileImage(cubit.postImage!),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(backgroundColor: Colors.grey.shade400,child: IconButton(
                              onPressed: (){
                                cubit.removePostImage();
                              },
                              icon: const Icon(Icons.close,color: Colors.white,))
                          ),
                        )
                      ]
                  ),
                  if(cubit.postImage != null)const SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                            onPressed: (){
                              cubit.getPostImagePick();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(IconBroken.Image),
                                SizedBox(width: 5,),
                                Text('Add photo')
                              ],
                            )
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: (){},
                            child: const Text('#Tags')
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}