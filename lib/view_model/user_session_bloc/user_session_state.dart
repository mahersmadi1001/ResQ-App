part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionState {}

final class UserSessionInitial extends UserSessionState {}

class UserFirstTimeState extends UserSessionState {}

class UserAuthenticated extends UserSessionState {}

class UserUnAuth extends UserSessionState {}
