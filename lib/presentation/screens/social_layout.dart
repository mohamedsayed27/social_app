import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/presentation/screens/add_post.dart';
import 'package:social_app/presentation/style/icon_broken.dart';
import '../../business_logic/social_layout_cubit/social_cubit.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<SocialCubit,SocialState>(
        builder: (context , state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: cubit.appBarTitles[cubit.currentIndex],
              foregroundColor: Colors.black,
              actions: [
                IconButton(onPressed: (){}, icon: const Icon(IconBroken.Notification)),
                IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search))
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottomNav(index,context);
              },
                items: const [
                  BottomNavigationBarItem(icon: Icon(IconBroken.Home) , label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Chat) , label: 'Chats'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Plus) , label: 'Add post'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.User) , label: 'Users'),
                  BottomNavigationBarItem(icon: Icon(IconBroken.Setting) , label: 'Settings'),
                ]
            ),
          );
        },
        listener: (context , state){
          if(state is AddPostScreenState){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPostScreen()));
          }
        }
    );
  }
}
