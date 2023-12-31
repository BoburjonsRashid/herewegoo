class Post {
  String? firstname;
  String? lastname;
  String? content;
  String? date;

  Post({this.firstname, this.lastname, this.content, this.date});
  Post.fromJson(Map<String, dynamic> json)
      : firstname = json['firstname'],
        lastname = json['lastname'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
    'firstname': firstname,
    'lastname': lastname,
    'content': content,
    'date': date,
  };
}
