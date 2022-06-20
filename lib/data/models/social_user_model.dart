class SocialUserModel{
   String? name;
   String? email;
   String? phone;
   String? userId;
   String? bio;
   String? image;
   SocialUserModel({
     this.email,
     this.phone,
     this.name,
     this.userId,
     this.image,
     this.bio
});
  SocialUserModel.fromJson(Map<String , dynamic> json){
    email= json["email"];
    name = json["name"];
    image = json["image"];
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
    };
  }
}