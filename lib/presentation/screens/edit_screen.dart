import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_cubit.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

import '../components.dart';



class EditProfile extends StatelessWidget {
   EditProfile({Key? key}) : super(key: key);
   final nameController = TextEditingController();
   final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context , state) {
          var userModel = SocialCubit.get(context).socialUserModel;
          var cubit = SocialCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: buildAppBar(
              appBarTitleWidget: const Text('Edit Profile'),
              leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconBroken.Arrow___Left_2)),
              actions: [
                buildTextButton(onPress: (){}, child: const Text('UPDATE')),
                const SizedBox(width: 20,)
              ],
            ),
            body: ConditionalBuilder(
                condition: userModel != null,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                        SizedBox(
                        height: 250,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Align(
                              alignment: AlignmentDirectional.topCenter,
                              child: Stack(
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
                                            image: NetworkImage('${userModel!.cover}'),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(backgroundColor: Colors.grey.shade400,child: IconButton(onPressed: (){}, icon: const Icon(IconBroken.Camera,color: Colors.white,))),
                                  )
                                ]
                              ),
                            ),
                            Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                CircleAvatar(
                                  radius: 84,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    backgroundImage:cubit.profileImage == null ?  NetworkImage('${userModel.image}') : FileImage(cubit.profileImage!) as ImageProvider,
                                    radius: 76,
                                  ),
                                ),
                                CircleAvatar(backgroundColor: Colors.grey.shade400,child: IconButton(onPressed: (){cubit.getImagePick();}, icon: const Icon(IconBroken.Camera,color: Colors.white,)))
                              ]
                            )
                          ],
                        ),
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                          defaultFormField(
                              prefixIcon: IconBroken.User,
                              controller: nameController,
                              label: 'Name',
                              validate: (String value){
                                  if(value.isEmpty){
                                    return 'Please Enter Your name';
                                  }
                              }
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultFormField(
                            prefixIcon: IconBroken.Info_Circle,
                            controller: bioController,
                            label: 'Bio',
                              validate: (String value){
                                if(value.isEmpty){
                                  return 'Please Enter Your name';
                                }
                              }
                          )
                        ],
                      ),
                    ),
                  );
                },
                fallback: (context) => const Center(child: CircularProgressIndicator(),)),
          );},
        listener: (context , state){});
  }
}
