class UserPlanModel {
  String? recurringTypeId;
  String? title;
  String? description;
  double? discountPercent;
  double? finalPrice;
  bool? isEcoCleaning;
  bool? materialsProvidedByClient;

  UserPlanModel(
      {this.recurringTypeId,
      this.title,
      this.description,
      this.discountPercent,
      this.finalPrice,
      this.isEcoCleaning,
      this.materialsProvidedByClient});

  UserPlanModel.fromJson(Map<String, dynamic> json) {
    recurringTypeId = json['recurringTypeId'];
    title = json['title'];
    description = json['description'];
    discountPercent =
        double.tryParse((json['discountPercent'] ?? "0").toString());
    finalPrice = double.tryParse((json['finalPrice'] ?? "0").toString());
    isEcoCleaning = json['isEcoCleaning'];
    materialsProvidedByClient = json['materialsProvidedByClient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recurringTypeId'] = this.recurringTypeId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['discountPercent'] = this.discountPercent;
    data['finalPrice'] = this.finalPrice;
    data['isEcoCleaning'] = this.isEcoCleaning;
    data['materialsProvidedByClient'] = this.materialsProvidedByClient;
    return data;
  }
}
