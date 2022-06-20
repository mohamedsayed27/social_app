import 'package:flutter/material.dart';
import 'package:social_app/presentation/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 10.0,
            margin: const EdgeInsets.only(right: 8.0,left: 8.0,bottom: 8.0,top: 0),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: const [
                Image(
                    image: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/48/07/84/1000_F_348078448_YLQP7PyisReZZzuU6snFFE4C4TxSNkel.jpg')),
                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Communicate With Friends',style: TextStyle(color: Colors.white,fontSize: 17),),
                ),
              ],
            ),
          ),
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/02/78/26/1000_F_302782694_VftvTDVoDT6kYW3lXTqvp8bmH3inmpT8.jpg'),
                        radius: 25,
                      ),
                      const SizedBox(width:10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Anyone Here',style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold,height: 1.3)),
                                SizedBox(width: 3,),
                                Icon(Icons.verified,color: Colors.blue,size: 15,)
                              ],
                            ),
                            Text('27 May 2022',style: TextStyle(fontSize: 12,color: Colors.grey,height: 1.3))
                          ],
                        ),
                      ),
                      const SizedBox(width:10),
                      IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz,size: 20,))
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const Text(
                      'A paragraph is a series of sentences that are organized and coherent, and are all related to a single topic. Almost every piece of writing you do that is longer than a few sentences should be organized into paragraphs. ' ,
                      style: TextStyle(height: 1.3,fontSize: 14,),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      children: [
                         Container(
                            height: 20.0,
                            child: MaterialButton(
                                onPressed: (){},
                                minWidth: 1.0,
                                padding: EdgeInsets.zero,
                                child: Text(
                                  '#Flutter',
                                  style: Theme.of(context).textTheme.caption!.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    height: 170,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                          image: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/36/23/26/1000_F_336232613_7hIOJ9qX5FkqEU4Mxi01ZxuaaMl30a0y.jpg'),
                        fit: BoxFit.cover

                      )
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: InkWell(
                            onTap: (){},
                            child: Padding(
                                padding: EdgeInsets.only(top: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(IconBroken.Heart,color: Colors.red,),
                                  SizedBox(width: 5,),
                                  Text('120'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                    padding:  EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/02/78/26/1000_F_302782694_VftvTDVoDT6kYW3lXTqvp8bmH3inmpT8.jpg'),
                        radius: 20,
                      ),
                      SizedBox(width: 10.0,),
                      Text('Write a comment .....'),
                      Spacer(),
                      InkWell(
                        onTap: (){},
                        child: Padding(
                          padding: EdgeInsets.only(top: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('like'),
                              SizedBox(width: 5,),
                              Icon(IconBroken.Heart,color: Colors.red,),


                            ],
                          ),
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}


