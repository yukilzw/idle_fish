import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> {

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Column(
      children: [
        SizedBox(
          height: statusBarHeight,
        ),
        Container(
          height: 60,
          color: Colors.red[100],
        ),
        SizedBox(
          height: 400,
          child: PageView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                color: Colors.blue
              ),    
              Container(
                width: 200,
                height: 200,
                color: Colors.orange
              ),
              Container(
                width: 200,
                height: 200,
                color: Colors.yellow
              ), 
            ],
          ),
        ),
      ],
    );
  }
}