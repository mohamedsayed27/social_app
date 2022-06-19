import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10.0,
          margin: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: const [
              Image(image: NetworkImage('https://as1.ftcdn.net/v2/jpg/03/48/07/84/1000_F_348078448_YLQP7PyisReZZzuU6snFFE4C4TxSNkel.jpg')),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Communicate With Friends',style: TextStyle(color: Colors.white,fontSize: 17),),
              ),
            ],
          ),
        )
      ],
    );
  }
}
