import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_event.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final GetEventUseCase _eventUseCase;
  List<EventEntity> _allEvents = []; // Simpan semua event

  EventCubit({required GetEventUseCase eventUseCase})
      : _eventUseCase = eventUseCase,
        super(EventInitial());

  Future<void> fetchEvents() async {
    emit(EventLoading());
    final res = await _eventUseCase();
    res.fold(
      (failure) => emit(EventFailure(failure.message)),
      (events) {
        _allEvents = events;
        emit(EventLoaded(events)); // Muat semua event
      },
    );
  }

  void filterEvents(List<String> selectedCategories) {
    if (_allEvents.isEmpty) return;

    // Jika 'All' dipilih atau tidak ada kategori, tampilkan semua event
    if (selectedCategories.contains('All') || selectedCategories.isEmpty) {
      emit(EventLoaded(_allEvents));
    } else {
      // Filter event berdasarkan kategori yang dipilih
      final filteredEvents = _allEvents.where((event) {
        // Cek apakah setidaknya satu kategori event cocok dengan kategori yang dipilih
        return event.categories
            .any((category) => selectedCategories.contains(category));
      }).toList();

      emit(EventLoaded(filteredEvents));
    }
  }

  void filterEventsAndSearch({
    required List<String> categories,
    String searchQuery = '',
  }) {
    if (_allEvents.isEmpty) return;

    // Filter berdasarkan kategori dan pencarian
    final filteredEvents = _allEvents.where((event) {
      // Cek kategori
      final categoryMatch = categories.contains('All') ||
          event.categories.any((category) => categories.contains(category));

      // Cek pencarian (case-insensitive)
      final searchMatch = searchQuery.isEmpty ||
          event.name.toLowerCase().contains(searchQuery) ||
          event.categories
              .any((category) => category.toLowerCase().contains(searchQuery));

      return categoryMatch && searchMatch;
    }).toList();

    // Urutkan berdasarkan relevansi pencarian jika ada query
    if (searchQuery.isNotEmpty) {
      filteredEvents.sort((a, b) {
        // Beri bobot pada kecocokan nama
        final aNameMatch = a.name.toLowerCase().contains(searchQuery);
        final bNameMatch = b.name.toLowerCase().contains(searchQuery);

        if (aNameMatch && !bNameMatch) return -1;
        if (!aNameMatch && bNameMatch) return 1;

        // Jika nama cocok, bandingkan kategori
        final aCategoryMatch =
            a.categories.any((cat) => cat.toLowerCase().contains(searchQuery));
        final bCategoryMatch =
            b.categories.any((cat) => cat.toLowerCase().contains(searchQuery));

        if (aCategoryMatch && !bCategoryMatch) return -1;
        if (!aCategoryMatch && bCategoryMatch) return 1;

        return 0;
      });
    }

    emit(EventLoaded(filteredEvents));
  }
}
