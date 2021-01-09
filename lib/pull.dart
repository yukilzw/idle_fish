import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Pull extends StatefulWidget {
  Pull({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _Pull createState() => _Pull();
}

class _Pull extends State<Pull> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
    setState(() {

    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    Widget refreshing = Lottie.asset('assets/if_refresh.json',
      height: 50
    );
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: CustomHeader(
                refreshStyle: RefreshStyle.Follow,
                builder: (BuildContext context,RefreshStatus status) {
                  bool swimming = (status == RefreshStatus.refreshing || status == RefreshStatus.completed);
                  return Container(
                    height: 50,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        swimming ? SizedBox() : Image.asset('assets/fun_home_pull_down.png',
                            height: 50,
                        ),
                        Offstage(
                          offstage: !swimming,
                          child: Image.asset('assets/fun_home_pull_down.png',
                            height: 50,
                        ),
                        ),
                      ]
                    )
                  );
                }
              ),
              footer: CustomFooter(
                builder: (BuildContext context,LoadStatus mode){
                  Widget body ;
                  Widget loading = Lottie.asset('assets/loading.json',
                    height: 34
                  );
                  if(mode==LoadStatus.idle){
                    body = loading;
                  }
                  else if(mode==LoadStatus.loading){
                    body = loading;
                  }
                  else if(mode == LoadStatus.failed){
                    body = Text("加载失败！点击重试！");
                  }
                  else if(mode == LoadStatus.canLoading){
                    body = loading;
                  }
                  else{
                    body = Text("没有更多数据了!");
                  }
                  return Container(
                    height: 55.0,
                    child: Center(child:body),
                  );
                },
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
                itemExtent: 100.0,
                itemCount: items.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
