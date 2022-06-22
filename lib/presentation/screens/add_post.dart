import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_cubit.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

import '../components.dart';



class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
        builder: (context , state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: buildAppBar(
              appBarTitleWidget: cubit.appBarTitles[2],
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(IconBroken.Arrow___Left_2)),
          ),
          body: const Center(child: Text('Add Post'),),
        );},
        listener: (context , state){});
  }
}
