part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> props() {
    return [];
  }
}

class LoadCategories extends CategoryEvent {}

class UpdateCategories extends CategoryEvent {
  final List<Category> categories;
  const UpdateCategories(this.categories);
  @override
  List<Object?> props() {
    return [categories];
  }
}
