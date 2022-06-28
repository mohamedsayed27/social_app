import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_cubit.dart';
import 'package:social_app/business_logic/social_layout_cubit/social_state.dart';
import 'package:social_app/data/models/post_creation_model.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialState>(

        builder: (context , state){
          var posts = SocialCubit.get(context).posts;
          return ConditionalBuilder(
              condition: SocialCubit.get(context).socialUserModel !=null && posts.isNotEmpty,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 10.0,
                        margin: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 8.0,top: 0),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: const [
                            Image(
                              image: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/48/07/84/1000_F_348078448_YLQP7PyisReZZzuU6snFFE4C4TxSNkel.jpg'),fit: BoxFit.cover,width: double.infinity,),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Communicate With Friends',style: TextStyle(color: Colors.white,fontSize: 17),),
                            ),
                          ],
                        ),

                      ),
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics:const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index) => buildPostItem(context,posts[index],index),
                        separatorBuilder: (context,index) => const SizedBox(height: 5,),
                        itemCount: posts.length)
                  ],
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator(),));
        },
        listener: (context , state) {});
  }


  Widget buildPostItem(context, CreatePostModel model,index) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/02/78/26/1000_F_302782694_VftvTDVoDT6kYW3lXTqvp8bmH3inmpT8.jpg'),
                  radius: 27,
                ),
                const SizedBox(width:10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Text('Anyone Here',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,height: 1.3)),
                          SizedBox(width: 3,),
                          Icon(Icons.verified,color: Colors.blue,size: 15,)
                        ],
                      ),
                       Text(model.dateTime!,style: const TextStyle(fontSize: 12,color: Colors.grey,height: 1.3))
                    ],
                  ),
                ),
                const SizedBox(width:10),
                IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz,size: 20,))
              ],
            ),
            Padding(
              padding:  const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey.shade400,
              ),
            ),
             Text( model.text!,
              style: const TextStyle(height: 1.3,fontSize: 20,),
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: Wrap(
            //     children: [
            //       SizedBox(
            //         height: 20.0,
            //         child: MaterialButton(
            //           onPressed: (){},
            //           minWidth: 1.0,
            //           padding: EdgeInsets.zero,
            //           child: Text(
            //             '#Flutter',
            //             style: Theme.of(context).textTheme.caption!.copyWith(
            //               color: Colors.blue,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            if(model.postImage !='' )Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image:  DecorationImage(
                        image: NetworkImage(model.postImage!),
                        fit: BoxFit.cover

                    )
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:  [
                          const Icon(IconBroken.Heart,color: Colors.red,),
                          const SizedBox(width: 5,),
                          Text(
                              '${SocialCubit.get(context).likesNumber[index]}'
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(IconBroken.Message,color: Colors.amber,),
                          SizedBox(width:5.0),
                          Text('120 Comment'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding:  const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey.shade400,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(model.image!),
                          radius: 20,
                        ),
                        const SizedBox(width: 10.0,),
                        const Text('Write a comment .....'),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    SocialCubit.get(context).postLikes(SocialCubit.get(context).postsId[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  const[
                        Icon(IconBroken.Heart,color: Colors.red,),
                        SizedBox(width: 5,),
                        Text('Like'),

                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

