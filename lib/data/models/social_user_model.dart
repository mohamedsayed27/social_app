class SocialUserModel{
   String? name;
   String? email;
   String? phone;
   String? userId;
   String? bio;
   String? image;
   String? cover;
   SocialUserModel({
     this.email,
     this.phone,
     this.name,
     this.userId,
     this.image,
     this.cover,
     this.bio
});
  SocialUserModel.fromJson(Map<String , dynamic> json){
    email= json["email"];
    name = json["name"];
    image = json["image"];
    cover = json["cover"];
    phone = json["phone"];
    bio = json["bio"];
    userId = json['UId'];
  }


  Map<String,dynamic> toMap(){
    return {
      'email' : email,
      'phone' : phone,
      'name' : name,
      'UId' : userId,
      'bio' : bio,
      'image' : image,
      'cover' : cover,

    };
  }
}