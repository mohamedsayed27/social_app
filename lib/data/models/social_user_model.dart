class SocialUserModel{
   String? name;
   String? email;
   String? phone;
   String? userId;
   SocialUserModel({
     this.email,
     this.phone,
     this.name,
     this.userId
});
  SocialUserModel.fromJson(Map<String , dynamic> json){
    email= json["email"];
    name = json["name"];
    phone = json["phone"];
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