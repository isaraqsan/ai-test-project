enum HomeMenuType {
  outlet,
  promotion,
}

class HomeMenu {
  HomeMenuType? type;
  String? title;
  String? description;
  String? icon;

  HomeMenu({
    this.type,
    this.title,
    this.icon,
    this.description,
  });
}
