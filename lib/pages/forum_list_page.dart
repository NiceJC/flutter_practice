import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/common/common_view.dart';
import 'package:flutter_practice/entity/forum_Item_bean.dart';
import 'package:flutter_practice/entity/forum_reply_bean.dart';
import 'package:flutter_practice/pages/forum_detail_page.dart';

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
//  List<ForumItem> forumList = [];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  ///设置当前用户昵称
  String myUserName = "Bob";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initData();
  }

  _initData() {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chevron_left,
              size: 40,
            ),
          ),
          title: CommonView.newText("FORUM", 18, Colors.white,
              align: TextAlign.center),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: _forumList(),
            ),
            _postView()
          ],
        ),
      ),
    );
  }

  ///动态列表
  _forumList() {

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('forum')
          .orderBy("postTime",descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );

        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (BuildContext context, int index) {
            return _forumItemView(
              ForumItem.fromSnapshot(snapshot.data.documents[index]));

            },
        );
      },
    );
  }

  ///动态Item
  _forumItemView(ForumItem itemData) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
              return ForumDetailPage(itemData.postTime);

            }));
            
          },
          child: Container(
            height: 90,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CommonView.newText(
                        itemData.replyList == null
                            ? "0"
                            : itemData.replyList.length.toString(),
                        18,
                        Colors.black),
                    CommonView.newText("replies", 14, Colors.black),
                  ],
                ),
                Expanded(
                  child: Padding(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CommonView.newText(itemData.title, 16, Colors.blue,
                            maxLines: 2),
                        CommonView.newText(itemData.content, 14, Colors.black,
                            maxLines: 2),
                      ],
                    ),
                    padding: EdgeInsets.only(left: 10, right: 10),
                  ),
                ),
                Container(
                  width: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CommonView.newText(itemData.authorName, 14, Colors.black,maxLines: 2),
                      CommonView.newText(
                          itemData.postTime.toString().length > 14
                              ? itemData.postTime.toString().substring(0, 16)
                              : itemData.postTime.toString(),
                          12,
                          Colors.black,maxLines: 2,align:TextAlign.right),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: Color(0xfff1f1f1),
        )
      ],
    );
  }

  ///发布框
  _postView() {
    return Card(
      elevation: 5,
      margin: EdgeInsets.only(top: 5, bottom: 0, left: 0, right: 0),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
        child: Column(
          children: <Widget>[
            TextField(
              maxLines: 1,
              decoration: InputDecoration(hintText: "Topic"),
              controller: titleController,
            ),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(hintText: "Content"),
              controller: contentController,
            ),
            IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {
                List<ForumReply> replyList=[];
                replyList.add(ForumReply(content:contentController.text.toString(),

                    authorName: myUserName,replyTime: DateTime.now().toString()
                ));
                ForumItem forumItem = ForumItem(
                    authorName: myUserName,
                    title: titleController.text.toString(),
                    content: contentController.text.toString(),
                    postTime: DateTime.now().toString()

                    ,replyList: replyList
                );

                Firestore.instance.collection('forum').add(forumItem.toJson());
              },
            )
          ],
        ),
      ),
    );
  }
}
