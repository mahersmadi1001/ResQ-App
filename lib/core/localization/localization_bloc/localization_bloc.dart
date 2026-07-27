import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projct/core/config/di.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/service/cache_service.dart';
import 'package:projct/service/langauge_service.dart';
import 'localization_event.dart';
import 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final CacheService _cacheService;
  final LangaugeService langaugeService;
  LocalizationBloc({CacheService? cacheService, required this.langaugeService})
    : _cacheService = cacheService ?? di<CacheService>(),
      super(LocalizationInitState(langCode: Locale("en"))) {
    on<GetSavedLanguageEvent>(_onGetSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  void _onGetSavedLanguage(
    GetSavedLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) {
    final String savedLanguage = _cacheService.getLanguage();
    emit(LocalizationSuccessState(langCode: Locale(savedLanguage)));
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      bool result = await langaugeService.sendLanguage(
        languagelanCode: event.languageCode,
      );
      if (result) {
        await _cacheService.saveLanguage(event.languageCode);
        emit(LocalizationSuccessState(langCode: Locale(event.languageCode)));
      }
    } on Failure catch (e) {
      emit(LocalizationErrorState(errorMassege: e.message));
    } catch (e) {
      emit(LocalizationErrorState(errorMassege: e.toString()));
    }
  }
}
