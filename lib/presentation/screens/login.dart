import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/login_cubit/cubit.dart';
import 'package:social_app/business_logic/login_cubit/states.dart';
import 'package:social_app/data/local/cash_helper.dart';
import 'package:social_app/presentation/components.dart';
import 'package:social_app/presentation/screens/register.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
          builder: (context, state) => Scaffold(
                body: Center(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'LOGIN',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Login to contact with the world',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                              validate: (v){
                                if(v.isEmpty){
                                  return 'please en';
                                }
                              },
                            onSubmit: (){},
                              onChange: (){},
                              obscure: false,
                              controller: emailController,
                              prefixIcon: Icons.email,
                              label: 'Email',
                              hint: 'Enter your email'),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                            onSubmit: (){

                            },
                              obscure: SocialLoginCubit.get(context).isVisible,
                              validate: (v){
                              if(v.isEmpty){
                                return 'please en';
                              }
                              },
                              onChange: (){},
                              controller: passwordController,
                              prefixIcon: Icons.lock,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    SocialLoginCubit.get(context)
                                        .passwordVisible();
                                  },
                                  icon: SocialLoginCubit.get(context).suffix),
                              onTab: () {
                                SocialLoginCubit.get(context).passwordVisible();
                              },
                              label: 'password',
                              hint: 'Enter your password'),
                          const SizedBox(
                            height: 30,
                          ),
                          specialButton(
                              text: 'login',
                              onPress: (){
                                if(formKey.currentState!.validate()){
                                  SocialLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text);

                                }
                              }
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'You Don\'t have an Email.. ?',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                child: const Text('Register',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               RegisterScreen()));
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          listener: (context, state) {
            if(state is SocialLoginErrorState){
              showToast(msg:state.error.toString(),backColor: Colors.red, txtColor: Colors.white);
            }
          }),
    );
  }
}
