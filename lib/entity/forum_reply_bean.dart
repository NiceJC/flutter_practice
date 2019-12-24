class ForumReply {
  ///回复内容
  String content;

  ///回复人
  String authorName;

  ///回复时间
  String replyTime;

  ForumReply({this.content, this.authorName, this.replyTime});

  ForumReply.fromJson(Map<dynamic, dynamic> json) {
    content = json['content'];
    authorName = json['authorName'];
    replyTime = json['replyTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['authorName'] = this.authorName;
    data['replyTime'] = this.replyTime;
    return data;
  }
}
