import 'package:flutter/material.dart';

const testNav = [
  '全部 12343', '潮鞋 234', '手办 543', '家电 65', '数码 1285', '虚拟品 51', '服装 5415', '其他 4120'
];

class TabPage extends StatefulWidget {
  @override
  _TabPage createState() => _TabPage();
}

class _TabPage extends State<TabPage> {
  PageController pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    //创建控制器的实例
    pageController = PageController(
      //用来配置PageView中默认显示的页面 从0开始
      initialPage: 0,
      //为true是保持加载的每个页面的状态
      keepPage: true,
    );

    ///PageView设置滑动监听
    pageController.addListener(() {
      //PageView滑动的距离
      double offset = pageController.offset;
      //当前显示的页面的索引
      double page = pageController.page;
      // print("pageView 滑动的距离 $offset  索引 $page");
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) => pageController.jumpToPage(2)); //执行yourFunction
  }

  List<Widget> _renderNav() {
    return testNav.asMap().keys.map((index) =>
      GestureDetector(
        onTap: () {
          setState(() {
            currentPage = index;
          });
          pageController.animateToPage(
            index,
            curve: Curves.ease,
            duration: Duration(milliseconds: 500),
          );
        },
        child:  Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10
          ),
          color: Colors.transparent,
          child: Center(
            child: Text(
              testNav[index],
              style: currentPage == index ? TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17
              ) : TextStyle(
                color: Colors.black,
                fontSize: 14
              ),
            )
          ),
        ),
      )
    ).toList();
  }

  List<Widget> _renderPage() {
    List colors = [Colors.pinkAccent, Colors.blue, Colors.red, Colors.green, Colors.yellow, Colors.pink, Colors.black, Colors.purple, Colors.deepOrange];
    return testNav.asMap().map((i, text) {
      return MapEntry(i, Container(
          color: colors[i],
          child: Center(
            child: Text(text),
          ),
        )
      );
    }).values.toList();
  }

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
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _renderNav(),
          ),
        ),
        SizedBox(
          height: 400,
          child: PageView(
            controller: pageController,
            physics: BouncingScrollPhysics(),
            children: _renderPage(),
          ),
        ),
      ],
    );
  }
}