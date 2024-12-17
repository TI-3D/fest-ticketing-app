import 'package:bloc/bloc.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_categories.dart';

part 'categories_state.dart';
class CategoriesCubit extends Cubit<CategoryState> {
  final GetCategoriesUseCase _categoriesUseCase;

  CategoriesCubit({required GetCategoriesUseCase categoriesUseCase})
      : _categoriesUseCase = categoriesUseCase,
        super(CategoryInitial());

  Future<void> fetchCategories() async {
    emit(CategoryLoading());
    final res = await _categoriesUseCase();
    res.fold(
      (failure) => emit(CategoryFailure(failure.message)),
      (categories) => emit(CategoryLoaded(categories, ['All'])), // Default pilih 'All'
    );
  }

  void toggleCategory(String category, List<String> allCategories) {
    if (state is CategoryLoaded) {
      final currentState = state as CategoryLoaded;
      final currentSelected = List<String>.from(currentState.selectedCategories);

      if (category == 'All') {
        // Jika 'All' dipilih, reset ke 'All'
        emit(CategoryLoaded(allCategories, ['All']));
      } else {
        // Hapus 'All' dari selected jika sudah ada
        currentSelected.remove('All');

        if (currentSelected.contains(category)) {
          currentSelected.remove(category);
        } else {
          currentSelected.add(category);
        }

        // Jika tidak ada kategori yang dipilih, kembalikan ke 'All'
        if (currentSelected.isEmpty) {
          emit(CategoryLoaded(allCategories, ['All']));
        } else {
          // Jika semua kategori dipilih, kembalikan ke 'All'
          if (currentSelected.length == allCategories.length) {
            emit(CategoryLoaded(allCategories, ['All']));
          } else {
            emit(CategoryLoaded(allCategories, currentSelected));
          }
        }
      }
    }
  }
}
