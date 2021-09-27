class CategoryContentModel {
  late String title;
  late List<Desc> desc;

  CategoryContentModel({required this.title, required this.desc});

  CategoryContentModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['desc'] != null) {
      desc = <Desc>[];
      json['desc'].forEach((v) {
        desc.add(new Desc.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.desc != null) {
      data['desc'] = this.desc.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Desc {
  late String text;
  late String img;

  Desc({required this.text, required this.img});

  Desc.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['img'] = this.img;
    return data;
  }
}