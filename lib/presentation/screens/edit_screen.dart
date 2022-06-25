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
   final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context , state) {
          var userModel = SocialCubit.get(context).socialUserModel;
          var cubit = SocialCubit.get(context);
          nameController.text = userModel!.name!;
          bioController.text = userModel.bio!;
          phoneController.text = userModel.phone!;


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
                buildTextButton(
                    onPress: (){
                      cubit.updateUserData(phone: phoneController.text, bio: bioController.text, name: nameController.text);
                    },
                    child: const Text('UPDATE')),
                const SizedBox(width: 20,)
              ],
            ),
            body: Padding(
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
                                            image: cubit.coverImage == null? NetworkImage('${userModel.cover}') : FileImage(cubit.coverImage!) as ImageProvider,
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(backgroundColor: Colors.grey.shade400,child: IconButton(
                                        onPressed: (){
                                          cubit.getCoverPick();
                                        },
                                        icon: const Icon(IconBroken.Camera,color: Colors.white,))
                                    ),
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
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        if(cubit.profileImage != null) Expanded(
                            child: OutlinedButton(
                              onPressed: (){
                                cubit.uploadProfileImage(phone: phoneController.text, bio: bioController.text, name: nameController.text);
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.blue),
                                foregroundColor:MaterialStateProperty.all(Colors.white),
                                overlayColor:MaterialStateProperty.all(Colors.white24), ),
                              child: const Text('Upload Profile'),
                            )
                        ),
                        const SizedBox(width: 5,),
                        if(cubit.coverImage != null) Expanded(
                          child: OutlinedButton(
                            onPressed: (){
                              cubit.uploadCoverImage(phone: phoneController.text, bio: bioController.text, name: nameController.text);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              foregroundColor:MaterialStateProperty.all(Colors.white),
                              overlayColor:MaterialStateProperty.all(Colors.white24), ),
                            child: const Text('Upload cover'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is UpdateUserDataLoadingState) const LinearProgressIndicator(color: Colors.blue,),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultFormField(
                        onChange: (){},
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
                        onChange: (){},
                        prefixIcon: IconBroken.Info_Circle,
                        controller: bioController,
                        label: 'Bio',
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
                        onChange: (){},
                        prefixIcon: IconBroken.Call,
                        controller: phoneController,
                        label: 'Phone',
                        validate: (String value){
                          if(value.isEmpty){
                            return 'Please Enter Your Phone';
                          }
                        }
                    )
                  ],
                ),
              ),
            )
          );},
        listener: (context , state){});
  }
}
