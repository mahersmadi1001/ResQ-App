import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
import 'package:projct/model/report_model.dart';
import 'package:projct/service/report_service.dart';
import 'send_report_event.dart';
import 'send_report_state.dart';

class SendReportBloc extends Bloc<SendReportEvent, SendReportState> {
  final ReportService _reportService;

  SendReportBloc({ReportService? reportService})
      : _reportService = reportService ?? ReportService(),
        super(SendReportInitial()) {
    on<SubmitReportEvent>(_onSubmitReport);
  }

  Future<void> _onSubmitReport(
    SubmitReportEvent event,
    Emitter<SendReportState> emit,
  ) async {
    emit(SendReportLoading());
    try {
      // 1. Request location permission & get coordinates
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        emit(const SendReportFailure(
            error: 'تم رفض صلاحية الموقع بشكل دائم. يرجى تفعيلها من الإعدادات.'));
        return;
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      final List<File> mediaFiles = [];
      for (final AssetEntity asset in event.attachments) {
        final File? file = await asset.file;
        if (file != null) mediaFiles.add(file);
      }

      if (event.recordedAudioPath != null) {
        final audioFile = File(event.recordedAudioPath!);
        if (await audioFile.exists()) {
          mediaFiles.add(audioFile);
        }
      }

      final reportModel = ReportModel(
        latitude: position.latitude.toString(),
        longitude: position.longitude.toString(),
        newsType: event.incidentTypes.map((e) => e.value).toList(),
        body: event.text,
        media: mediaFiles,
      );

      final responseData = await _reportService.sendReport(reportModel: reportModel);

      emit(SendReportSuccess(responseData: responseData));
    } on Failure catch (e) {
      emit(SendReportFailure(error: e.message ?? 'حدث خطأ غير متوقع'));
    } catch (e) {
      emit(SendReportFailure(error: e.toString()));
    }
  }
}

