class MessageModel{
  String? receiverId;
  String? senderId;
  String? dateTime;
  String? messageText;

  MessageModel({
    this.dateTime,
    this.messageText,
    this.receiverId,
    this.senderId
    });

   MessageModel.fromJson(Map<String, dynamic> json){
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];
    messageText = json['messageText'];
   }

   Map<String, dynamic> toJson(){
     return {
       'receiverId' : receiverId ,
       'senderId' : senderId ,
       'dateTime' : dateTime ,
       'messageText' : messageText ,
     };
   }
}