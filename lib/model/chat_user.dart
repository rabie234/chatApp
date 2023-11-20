class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.createdAt,
    required this.id,
    required this.isOnline,
    required this.lastActivated,
    required this.pushToken,
    required this.about,
    required this.email,
  });
  late final String image;
  late final String name;
  late final String createdAt;
  late final String id;
  late final bool isOnline;
  late final String lastActivated;
  late final String pushToken;
  late final String email;
  late final String about;
  
  ChatUser.fromJson(Map<String, dynamic> json){
    image = json['image']??'';
    name = json['name']??'';
    createdAt = json['created_at']??'';
    id = json['id']??'';
    isOnline = json['is_online']??'';
    lastActivated = json['last_activated']??'';
    pushToken = json['push_token']??'';
    email = json['email']??'';
    about = json['about']??'';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['is_online'] = isOnline;
    data['last_activated'] = lastActivated;
    data['push_token'] = pushToken;
    data['email'] = email;
    data['about'] = about;
    return data;
  }
}