part of 'category_cubit.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<String> categories;

  CategoryLoaded(this.categories);
}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}