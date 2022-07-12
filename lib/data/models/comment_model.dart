class CommentModel{
  String? comment;
  String? image;
  String? name;


  CommentModel({this.comment,this.image,this.name});


  CommentModel.fromJson(Map<String, dynamic> json){
    name = json['name'];
    comment = json['comment'];
    image = json['image'];

  }
  Map<String , dynamic> toMap(){
    return {
      'comment' : comment ,
      'name' : name,
      'image' : image,
    };
  }
}