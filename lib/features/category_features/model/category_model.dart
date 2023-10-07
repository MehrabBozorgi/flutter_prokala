class CategoryModel {
  int? status;
  List<Category>? category;

  CategoryModel({
    this.status,
    this.category,
  });

  CategoryModel.fromJson(dynamic json) {
    status = json['status'];

    if (json['category'] != null) {
      category = [];
      json['category'].forEach((value) {
        category?.add(Category.fromJson(value));
      });
    }
  }
}

class Category {
  int? id;
  String? title;
  List<SubCategory>? subCategory;

  Category({
    this.id,
    this.title,
    this.subCategory,
  });

  Category.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];

    if (json['sub_category'] != null) {
      subCategory = [];
      json['sub_category'].forEatch((value) {
        subCategory?.add(SubCategory.fromJson(value));
      });
    }
  }
}

class SubCategory {
  int? id;
  String? parentId;
  String? title;
  String? image;

  SubCategory({
    this.id,
    this.parentId,
    this.title,
    this.image,
  });

  SubCategory.fromJson(dynamic json) {
    id = json['id'];
    parentId = json['parent_id'];
    title = json['title'];
    image = json['image'];
  }
}
