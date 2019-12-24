class FireBaseTest{

  String name;
  int votes;

  FireBaseTest({this.name, this.votes});

  FireBaseTest.fromJson(Map<String, dynamic> json) {
  name = json['name'];
  votes = json['votes'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['name'] = this.name;
  data['votes'] = this.votes;
  return data;
  }

}