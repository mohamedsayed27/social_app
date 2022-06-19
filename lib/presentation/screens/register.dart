import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/register_cubit/RegStates.dart';
import 'package:social_app/presentation/screens/social_layout.dart';

import '../../business_logic/register_cubit/RegCubit.dart';
import '../components.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
   final formKey = GlobalKey<FormState>();
   final emailController = TextEditingController();
   final passwordController = TextEditingController();
   final phoneController = TextEditingController();
   final userNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialRegisterCubit(),
            child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
                builder: (context , state){
                  return Scaffold(
                    appBar: AppBar(
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.white,
                        statusBarIconBrightness: Brightness.dark
                      ),
                      elevation: 0,
                      backgroundColor: Colors.white,
                      iconTheme: const IconThemeData(color: Colors.black),
                    ),
                    body:  Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'REGISTER',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const Text(
                                  'Register to contact with the world',
                                  style: TextStyle(fontSize: 15, color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                defaultFormField(
                                    validate: (v){
                                      if(v.isEmpty){
                                        return 'please enter your user name';
                                      }
                                    },
                                    onSubmit: (){},
                                    onChange: (){},
                                    obscure: false,
                                    controller: userNameController,
                                    prefixIcon: Icons.person,
                                    label: 'Name',
                                    hint: 'Enter your name'),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                    validate: (v){
                                      if(v.isEmpty){
                                        return 'please enter your email';
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
                                    obscure: SocialRegisterCubit.get(context).isVisible,
                                    validate: (v){
                                      if(v.isEmpty){
                                        return 'please enter your password';
                                      }
                                    },
                                    onChange: (){},
                                    controller: passwordController,
                                    prefixIcon: Icons.lock,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        SocialRegisterCubit.get(context).passwordVisible();
                                      },
                                      icon: SocialRegisterCubit.get(context).suffix,
                                    ),
                                    label: 'password',
                                    hint: 'Enter your password'
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                defaultFormField(
                                    validate: (v){
                                      if(v.isEmpty){
                                        return 'please enter your Phone';
                                      }
                                    },
                                    onSubmit: (){},
                                    onChange: (){},
                                    obscure: false,
                                    controller: phoneController,
                                    prefixIcon: Icons.phone,
                                    label: 'Phone',
                                    hint: 'Enter your phone'),
                                const SizedBox(
                                  height: 30,
                                ),
                                ConditionalBuilder(
                                    condition: state is! SocialRegisterLoadingState,
                                    builder: (context) => specialButton(
                                        text: 'Register',
                                        onPress: (){
                                          if(formKey.currentState!.validate()){
                                            SocialRegisterCubit.get(context).userRegister(
                                                email: emailController.text,
                                                password: passwordController.text,
                                                phone: phoneController.text,
                                                name: userNameController.text
                                            );
                                          }
                                        }
                                    ),
                                    fallback: (context) => const Center(child: CircularProgressIndicator(),))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                listener: (context , state){
                  if(state is SocialRegisterErrorState){
                    showToast(msg:state.error.toString(),backColor: Colors.red, txtColor: Colors.white);
                  }
                  if(state is SocialCreateSuccessState){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SocialLayout()), (route) => false);

                  }
                }),
    );
  }
}



