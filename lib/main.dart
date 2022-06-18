import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_app/bloc_observer.dart';
import 'package:social_app/data/local/cash_helper.dart';
import 'package:social_app/presentation/screens/login.dart';
import 'package:social_app/presentation/screens/social_layout.dart';
import 'firebase_options.dart';

void main() async{
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await CashHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  late Widget startWidget;
  var userId =  CashHelper.getData(key: 'uId');
  if(userId != null){
    startWidget = const SocialLayout();
  } else{
    startWidget = SocialLoginScreen();
  }

  runApp( MyApp(startWidget: startWidget,));

}

class MyApp extends StatelessWidget {
   MyApp({Key? key, required this.startWidget}) : super(key: key);
   final Widget startWidget;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: startWidget,
    );
  }
}
