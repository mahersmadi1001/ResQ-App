import 'package:equatable/equatable.dart';

abstract class SendReportState extends Equatable {
  const SendReportState();

  @override
  List<Object?> get props => [];
}

class SendReportInitial extends SendReportState {}

class SendReportLoading extends SendReportState {}

class SendReportSuccess extends SendReportState {
  final Map<String, dynamic> responseData;

  const SendReportSuccess({required this.responseData});

  @override
  List<Object?> get props => [responseData];
}

class SendReportFailure extends SendReportState {
  final String error;

  const SendReportFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
