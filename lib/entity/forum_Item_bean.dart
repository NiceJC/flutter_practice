
import 'forum_reply_bean.dart';

class ForumItem {
  ///回复列表
  List<ForumReply> replyList=[];

  ///帖子标题
  String title;

  ///帖子内容
  String content;

  ///作者名称
  String authorName;

  ///发布时间
  DateTime postTime;

  ForumItem(this.replyList, this.title, this.content, this.authorName,
      this.postTime);


}
