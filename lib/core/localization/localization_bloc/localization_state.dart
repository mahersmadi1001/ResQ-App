// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LocalizationState extends Equatable {}

class LocalizationErrorState extends LocalizationState {
  String errorMassege;
  LocalizationErrorState({required this.errorMassege});

  @override
  List<Object?> get props => [errorMassege];
}

class LocalizationSuccessState extends LocalizationState {
  final Locale langCode;

  LocalizationSuccessState({required this.langCode});

  @override
  List<Object?> get props => [langCode];
}

class LocalizationInitState extends LocalizationState {
  final Locale langCode;

  LocalizationInitState({required this.langCode});
  @override
  List<Object?> get props => [];
}
