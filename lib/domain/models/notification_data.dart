class NotificationData {
  String? title;
  String? message;
  String? link;

  NotificationData({
    this.title,
    this.message,
    this.link,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    link = json['link'];
  }
}
