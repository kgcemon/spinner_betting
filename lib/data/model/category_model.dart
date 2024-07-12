class CategoryModel {
  List<Spinners>? spinners;

  CategoryModel({this.spinners});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['spinners'] != null) {
      spinners = <Spinners>[];
      json['spinners'].forEach((v) {
        spinners!.add(new Spinners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spinners != null) {
      data['spinners'] = this.spinners!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Spinners {
  int? id;
  String? spinnerName;
  int? spinnerPrice;
  int? duration;
  String? createdAt;

  Spinners(
      {this.id,
        this.spinnerName,
        this.spinnerPrice,
        this.duration,
        this.createdAt});

  Spinners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    spinnerName = json['spinner_name'];
    spinnerPrice = json['spinner_price'];
    duration = json['duration'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spinner_name'] = this.spinnerName;
    data['spinner_price'] = this.spinnerPrice;
    data['duration'] = this.duration;
    data['created_at'] = this.createdAt;
    return data;
  }
}
