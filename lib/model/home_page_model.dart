class HomePageModel {
  late List<Swipers> swipers;
  late List<Logos> logos;
  late List<Quicks> quicks;
  late PageRow? pageRow;

  HomePageModel({required this.swipers, required this.logos, required this.quicks, required this.pageRow});

  HomePageModel.fromJson(Map<String, dynamic> json) {
    if (json['swipers'] != null) {
      swipers = <Swipers>[];
      json['swipers'].forEach((v) {
        swipers.add(new Swipers.fromJson(v));
      });
    }
    if (json['logos'] != null) {
      logos = <Logos>[];
      json['logos'].forEach((v) {
        logos.add(new Logos.fromJson(v));
      });
    }
    if (json['quicks'] != null) {
      quicks = <Quicks>[];
      json['quicks'].forEach((v) {
        quicks.add(new Quicks.fromJson(v));
      });
    }
    if (json['pageRow'] != null) {
      pageRow = new PageRow.fromJson(json['pageRow']);
    } else {
      pageRow = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.swipers != null) {
      data['swipers'] = this.swipers.map((v) => v.toJson()).toList();
    }
    if (this.logos != null) {
      data['logos'] = this.logos.map((v) => v.toJson()).toList();
    }
    if (this.quicks != null) {
      data['quicks'] = this.quicks.map((v) => v.toJson()).toList();
    }
    if (this.pageRow != null) {
      data['pageRow'] = this.pageRow!.toJson();
    }
    return data;
  }
}

class Swipers {
  late String image;

  Swipers({required this.image});

  Swipers.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Logos {
  late String image;
  late String title;

  Logos({required this.image, required this.title});

  Logos.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    return data;
  }
}

class Quicks {
  late String image;
  late String price;

  Quicks({required this.image, required this.price});

  Quicks.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['price'] = this.price;
    return data;
  }
}

class PageRow {
  late List<String> ad1;
  late List<String> ad2;

  PageRow({required this.ad1, required this.ad2});

  PageRow.fromJson(Map<String, dynamic> json) {
    ad1 = json['ad1'].cast<String>();
    ad2 = json['ad2'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ad1'] = this.ad1;
    data['ad2'] = this.ad2;
    return data;
  }
}