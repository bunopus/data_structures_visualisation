class Menu {
  String name;
  String url;

  Menu(this.name, this.url) {}
}

class Chapter {
  String name;
  List<Menu> menuItems;

  Chapter(this.name, this.menuItems) {}
}

class ChapterMenu {
  Chapter chapter;
}
