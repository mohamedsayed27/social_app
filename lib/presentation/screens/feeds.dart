import 'package:flutter/material.dart';

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
            elevation: 10.0,
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
                  Text(
                      'A paragraph is a series of sentences that are organized and coherent, and are all related to a single topic. Almost every piece of writing you do that is longer than a few sentences should be organized into paragraphs. This is because paragraphs show a reader where the subdivisions of an essay begin and end, and thus help the reader see the organization of the essay and grasp its main points.' ,
                      style: TextStyle(height: 1.3,fontSize: 14,),
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5,),
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
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
