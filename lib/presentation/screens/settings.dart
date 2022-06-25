import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_cubit.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/components.dart';
import 'package:social_app/presentation/screens/add_post.dart';
import 'package:social_app/presentation/screens/edit_screen.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(
        builder: (context, state){
          var model = SocialCubit.get(context).socialUserModel;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
                condition: model != null,
                builder: (context) => Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: 175,
                              width: double.infinity,
                              decoration:  BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                      image: NetworkImage('${model!.cover}'),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 81,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage('${model.image}'),
                              radius: 76,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model.name}',
                      style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${model.bio}',
                      style: Theme.of(context).textTheme.caption,),
                    Padding(
                      padding:  const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  '100',
                                  style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                                Text(
                                  'posts',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  '40',
                                  style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                                Text(
                                  'photos',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  '10k',
                                  style:  TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                                Text(
                                  'follower',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  '100k',
                                  style: TextStyle(fontSize: 15 , fontWeight: FontWeight.bold),),
                                Text(
                                  'following',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                              onPressed: (){
                                navigateTo(context: context, navigatedScreen:  AddPostScreen());
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                                  foregroundColor:MaterialStateProperty.all(Colors.white),
                              overlayColor:MaterialStateProperty.all(Colors.white24), ),
                              child: const Text('Add Post'),
                            )
                        ),
                        const SizedBox(width: 5,),
                        OutlinedButton(
                            onPressed: (){
                              navigateTo(context: context, navigatedScreen:   EditProfile());
                            },
                            child: const Icon(IconBroken.Edit,size: 20,),

                        )
                      ],
                    ),

                  ],
                ),
                fallback: (context) => const Center(child:  CircularProgressIndicator(),)),
          );
        },
        listener: (context, state){});
  }
}
