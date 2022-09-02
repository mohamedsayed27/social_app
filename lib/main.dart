import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/domain/social_layout_cubit/social_cubit.dart';
import 'package:social_app/data/local/cash_helper.dart';
import 'package:social_app/presentation/screens/login.dart';
import 'package:social_app/presentation/screens/social_layout.dart';
import 'constants.dart';
import 'firebase_options.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? token =  await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
  });

  print(token);
  late Widget startWidget;
   userId =  CashHelper.getData(key: 'uId');
  if(userId != null){
    startWidget = const SocialLayout();
  } else{
    startWidget = SocialLoginScreen();
  }

  runApp( MyApp(startWidget: startWidget,));

}

class MyApp extends StatelessWidget {
   const MyApp({Key? key, required this.startWidget}) : super(key: key);
   final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => SocialCubit()..getUsers()..getPosts()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: startWidget,
        ));
  }
}
