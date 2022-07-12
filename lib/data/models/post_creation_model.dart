class CreatePostModel{
  String? name;
  String? uId;
  String? image;
  String? text;
  String? dateTime;
  String? postImage;


  CreatePostModel({
    this.name,
    this.text,
    this.image,
    this.dateTime,
    this.postImage,
    this.uId,
});

  CreatePostModel.fromJson(Map<String ,dynamic> json){

    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
  }


  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'UId' : uId,
      'image' : image,
      'postImage' : postImage,
      'dateTime' : dateTime,
      'text' : text,

    };
  }

}