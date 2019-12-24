import 'package:cloud_firestore/cloud_firestore.dart';

import 'forum_reply_bean.dart';

class ForumItem {
  ///帖子标题
  String title;

  ///帖子内容
  String content;

  ///作者名称
  String authorName;

  ///发布时间
  String postTime;

  DocumentReference reference;

  ///回复列表
  List<ForumReply> replyList;

  ForumItem(
      {this.title,
      this.content,
      this.authorName,
      this.postTime,
      this.replyList});

  ForumItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data, reference: snapshot.reference);


  ForumItem.fromJson(Map<String, dynamic> json, {this.reference}) {
    title = json['title'];
    content = json['content'];
    authorName = json['authorName'];
    postTime = json['postTime'];
    if (json['replyList'] != null) {
      replyList = new List<ForumReply>();
      json['replyList'].forEach((v) {
        replyList.add(new ForumReply.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['authorName'] = this.authorName;
    data['postTime'] = this.postTime;
    if (this.replyList != null) {
      data['replyList'] = this.replyList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
