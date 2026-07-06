import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:projct/core/erorr/erorr_handling.dart';
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
        emit(const SendReportFailure(error: 'تم رفض صلاحية الموقع بشكل دائم. يرجى تفعيلها من الإعدادات.'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );

      // 2. Convert attachments (AssetEntity) to real Files
      List<File> mediaFiles = [];
      for (AssetEntity asset in event.attachments) {
        File? file = await asset.file;
        if (file != null) mediaFiles.add(file);
      }

      // 3. Add audio file if present
      if (event.recordedAudioPath != null) {
        final audioFile = File(event.recordedAudioPath!);
        if (await audioFile.exists()) {
          mediaFiles.add(audioFile);
        }
      }

      // 4. Extract news types as strings
      final List<String> newsTypes = event.incidentTypes.map((e) => e.value).toList();

      // 5. Call service
      final responseData = await _reportService.sendReport(
        bodyText: event.text,
        latitude: position.latitude,
        longitude: position.longitude,
        newsType: newsTypes,
        mediaFiles: mediaFiles,
      );

      emit(SendReportSuccess(responseData: responseData));
    } on Failure catch (e) {
      emit(SendReportFailure(error: e.message ?? 'حدث خطأ غير متوقع'));
    } catch (e) {
      emit(SendReportFailure(error: e.toString()));
    }
  }
}
