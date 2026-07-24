import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/service/cache_service.dart';
import 'localization_event.dart';
import 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final CacheService _cacheService;

  LocalizationBloc({CacheService? cacheService})
    : _cacheService = cacheService ?? di<CacheService>(),
      super(const LocalizationState(Locale('en'))) {
    on<GetSavedLanguageEvent>(_onGetSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  void _onGetSavedLanguage(
    GetSavedLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) {
    final String savedLanguage = _cacheService.getLanguage();
    emit(LocalizationState(Locale(savedLanguage)));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    await _cacheService.saveLanguage(event.languageCode);
    emit(LocalizationState(Locale(event.languageCode)));
  }
}
