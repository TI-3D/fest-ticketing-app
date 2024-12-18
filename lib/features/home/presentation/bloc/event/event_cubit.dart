import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fest_ticketing/common/enitites/event.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_event.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_event_newest.dart';
import 'package:fest_ticketing/features/home/domain/usecase/get_event_popular.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final GetEventUseCase _eventUseCase;
  final GetEventNewestUseCase _eventNewestUseCase;
  final GetEventPopularUseCase _eventPopularUseCase;

  List<EventEntity> _allEvents = []; // Simpan semua event
  List<EventEntity> _allEventsPopular = []; // Simpan semua event populer
  List<EventEntity> _allEventsNewest = []; // Simpan semua event mendatang

  EventCubit({
    required GetEventUseCase eventUseCase,
    required GetEventNewestUseCase eventNewestUseCase,
    required GetEventPopularUseCase eventPopularUseCase,
  })  : _eventUseCase = eventUseCase,
        _eventNewestUseCase = eventNewestUseCase,
        _eventPopularUseCase = eventPopularUseCase,
        super(EventInitial());

  Future<void> fetchEvents() async {
    emit(EventLoading());

    // Mengambil semua event
    final allEventsResult = await _eventUseCase();
    final newestEventsResult = await _eventNewestUseCase();
    final popularEventsResult = await _eventPopularUseCase();
    allEventsResult.fold(
      (failure) => emit(EventFailure(failure.message)),
      (events) {
        _allEvents = events;
        newestEventsResult.fold(
          (failure) => emit(EventFailure(failure.message)),
          (events) {
            _allEventsNewest = events;
            popularEventsResult.fold(
              (failure) => emit(EventFailure(failure.message)),
              (events) {
                _allEventsPopular = events;
                emit(EventLoaded(
                    _allEvents, _allEventsPopular, _allEventsNewest));
              },
            );
          },
        );
      },
    );

    // final newestEventsResult = await _eventNewestUseCase();
    // final popularEventsResult = await _eventPopularUseCase();

    // Menangani hasil untuk semua event
    // if (allEventsResult.isLeft()) {
    //   emit(EventFailure(allEventsResult.fold((l) => l.message, (r) => '')));
    //   return;
    // }

    // Menangani hasil untuk event terbaru
    // if (newestEventsResult.isLeft()) {
    //   emit(EventFailure(newestEventsResult.fold((l) => l.message, (r) => '')));
    //   return;
    // }

    // // Menangani hasil untuk event populer
    // if (popularEventsResult.isLeft()) {
    //   emit(EventFailure(popularEventsResult.fold((l) => l.message, (r) => '')));
    //   return;
    // }

    // Jika semua berhasil
    // _allEvents = allEventsResult.getOrElse(() => []);
    // final newestEvents = newestEventsResult.getOrElse(() => []);
    // final popularEvents = popularEventsResult.getOrElse(() => []);

    // emit(EventLoaded(
    //   _allEvents,
    //   _allEventsPopular,
    //   _allEventsNewest,
    // ));
  }

  void filterEvents(List<String> selectedCategories) {
    if (_allEvents.isEmpty) return;

    // Jika 'All' dipilih atau tidak ada kategori, tampilkan semua event
    if (selectedCategories.contains('All') || selectedCategories.isEmpty) {
      emit(EventLoaded(_allEvents, _allEventsPopular, _allEventsNewest));
    } else {
      // Filter event berdasarkan kategori yang dipilih
      final filteredEvents = _allEvents.where((event) {
        // Cek apakah setidaknya satu kategori event cocok dengan kategori yang dipilih
        return event.categories
            .any((category) => selectedCategories.contains(category));
      }).toList();

      // Filter event populer
      final filteredEventsPopular = _allEventsPopular.where((event) {
        return event.categories
            .any((category) => selectedCategories.contains(category));
      }).toList();

      // Filter event terbaru
      final filteredEventsNewest = _allEventsNewest.where((event) {
        return event.categories
            .any((category) => selectedCategories.contains(category));
      }).toList();
      emit(EventLoaded(
          filteredEvents, filteredEventsPopular, filteredEventsNewest));
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
          event.categories.any((category) =>
              category?.toLowerCase().contains(searchQuery) ?? false);

      return categoryMatch && searchMatch;
    }).toList();

    // Filter event populer
    final filteredEventsPopular = _allEventsPopular.where((event) {
      final categoryMatch = categories.contains('All') ||
          event.categories.any((category) => categories.contains(category));
      final searchMatch = searchQuery.isEmpty ||
          event.name.toLowerCase().contains(searchQuery) ||
          event.categories.any((category) =>
              category?.toLowerCase().contains(searchQuery) ?? false);
      return categoryMatch && searchMatch;
    }).toList();

    // Filter event terbaru
    final filteredEventsNewest = _allEventsNewest.where((event) {
      final categoryMatch = categories.contains('All') ||
          event.categories.any((category) => categories.contains(category));
      final searchMatch = searchQuery.isEmpty ||
          event.name.toLowerCase().contains(searchQuery) ||
          event.categories.any((category) =>
              category?.toLowerCase().contains(searchQuery) ?? false);
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
        final aCategoryMatch = a.categories
            .any((cat) => cat?.toLowerCase().contains(searchQuery) ?? false);
        final bCategoryMatch = b.categories
            .any((cat) => cat?.toLowerCase().contains(searchQuery) ?? false);

        if (aCategoryMatch && !bCategoryMatch) return -1;
        if (!aCategoryMatch && bCategoryMatch) return 1;

        return 0;
      });
    }

    emit(EventLoaded(
        filteredEvents, filteredEventsPopular, filteredEventsNewest));
  }
}
