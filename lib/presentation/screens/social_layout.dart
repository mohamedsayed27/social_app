import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';

import '../../business_logic/social_layout_cubit/social_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialState>(
        builder: (context , state) =>Scaffold(
          appBar: AppBar(),
          body: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [Text('WELCOME TO SOCIAL APP LAYOUT')],),),
        ),
        listener: (context , state){}
    );
  }
}
