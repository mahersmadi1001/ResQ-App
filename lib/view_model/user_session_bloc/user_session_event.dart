part of 'user_session_bloc.dart';

@immutable
sealed class UserSessionEvent {}

class UserSessionCheckStatus extends UserSessionEvent {}

class CompleteOnboarding extends UserSessionEvent {}

class LogingUser extends UserSessionEvent {}

class Signout extends UserSessionEvent {}
