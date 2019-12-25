import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/common/common_view.dart';
import 'package:flutter_practice/entity/forum_Item_bean.dart';
import 'package:flutter_practice/entity/forum_reply_bean.dart';

///动态详情页
class ForumDetailPage extends StatefulWidget {
//  final DocumentReference reference;

  final String postTime;

  ForumDetailPage(this.postTime);

  @override
  State createState() {
    return ForumDetailState();
  }
}

class ForumDetailState extends State<ForumDetailPage> {
  TextEditingController contentController = TextEditingController();

  ///设置当前用户昵称
  String myUserName = "lisa";

  ForumItem forumItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
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
              child: _detailView(),
            ),
            _postView()
          ],
        ),
      ),
    );
  }

  _detailView() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('forum')
          .where("postTime", isEqualTo: widget.postTime)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.documents.length == 0)
          return Center(
            child: CircularProgressIndicator(),
          );

        return _forumDetail(ForumItem.fromSnapshot(snapshot.data.documents[0]));
      },
    );
  }

  _forumDetail(ForumItem item) {
    forumItem = item;

    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CommonView.newText(item.content, 18, Colors.black,
                align: TextAlign.start),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.perm_identity,
                      ),
                      CommonView.newText(item.authorName, 12, Colors.black),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.access_time),
                      CommonView.newText(
                          item.postTime.substring(0, 16), 12, Colors.black),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 20,
              alignment: Alignment.center,
              color: Colors.blue,
              child: CommonView.newText(
                  "Replies:${item.replyList == null ? 0 : item.replyList
                      .length}",
                  12,
                  Colors.white),
            ),
            Expanded(
              child: item.replyList == null
                  ? CommonView.newText("No Reply", 16, Colors.black)
                  : ListView.builder(
                  shrinkWrap: true,
                  itemCount: item.replyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _replyItemView(item.replyList[item.replyList.length-index-1]);
                  }),
            )
          ],
        ));
  }

  ///回复列表项
  _replyItemView(ForumReply replyData) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10,top: 15,bottom: 15),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.perm_contact_calendar,
                ),
                CommonView.newText(replyData.authorName, 12, Colors.black)
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(child: CommonView.newText(
                    replyData.content, 18, Colors.black),
                   padding:EdgeInsets.only(left: 5,)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(child: Icon(Icons.access_time,size: 16,),
                      padding: (EdgeInsets.only(right: 5)),),
                    CommonView.newText(replyData.replyTime.substring(0, 16),
                        12, Colors.black),
                  ],

                ),
              ],
            ),
          )
        ],
      ),
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
              maxLines: 4,
              decoration: InputDecoration(hintText: "Your reply..."),
              controller: contentController,
            ),
            IconButton(
              icon: Icon(Icons.send),
              color: Colors.blue,
              onPressed: () {
                List<ForumReply> replyList = [];
                replyList.add(ForumReply(
                    content: contentController.text.toString(),
                    authorName: myUserName,
                    replyTime: DateTime.now().toString()));

                if (forumItem != null)
                  //record.reference.updateData({'votes': FieldValue.increment(-1)})
                  forumItem.reference.updateData({'replyList': FieldValue.arrayUnion(replyList.map((v) => v.toJson()).toList())});

//                forumItem.reference.updateData(data)

                },
            )
          ],
        ),
      ),
    );
  }
}
