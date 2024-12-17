part of 'categories_cubit.dart';

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<String> allCategories; // Semua kategori yang tersedia
  final List<String> selectedCategories; // Kategori yang sedang dipilih

  CategoryLoaded(this.allCategories, this.selectedCategories);
}

class CategoryFailure extends CategoryState {
  final String message;

  CategoryFailure(this.message);
}
