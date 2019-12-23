import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/common/common_view.dart';
import 'package:flutter_practice/entity/forum_Item_bean.dart';


///动态列表页面

class ForumListPage extends StatefulWidget {
  @override
  ForumListSate createState() {
    // TODO: implement createState
    return ForumListSate();
  }
}

///总体页面结构 从上到下为 appbar-动态列表-发布框
class ForumListSate extends State<ForumListPage> {
  List<ForumItem> forumList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  ///生成一些数据
  _initData() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: _forumList(),
            ),
            Container(
              height: 150,
              child: Card(),
            )
          ],
        ),
      ),
    );
  }

  ///动态列表
  _forumList() {
    ListView.builder(
      itemCount: forumList.length,
      itemBuilder: (BuildContext context, int index) {
        return _forumItemView(forumList[index]);
      },
    );
  }

  ///动态Item
  _forumItemView(ForumItem itemData) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CommonView.newText(
                  itemData.replyList.length.toString(), 15, Colors.black),
              CommonView.newText("replies", 12, Colors.black),
            ],
          ),
          Expanded(
            child: Padding(
              child: Column(
                children: <Widget>[
                  CommonView.newText(itemData.title, 16, Colors.blue,
                      maxLines: 2),
                  CommonView.newText(itemData.content, 12, Colors.black,
                      maxLines: 2),
                ],
              ),
              padding: EdgeInsets.only(left: 10, right: 15),
            ),
          ),
          Container(
            width: 80,
            child: Column(
              children: <Widget>[
                CommonView.newText(itemData.authorName, 14, Colors.black),
                CommonView.newText(
                    itemData.postTime.toString(), 12, Colors.black),
              ],
            ),
          )
        ],
      ),
    );
  }

  ///发布框
  _postView() {}
}
