part of 'auth_flow_bloc.dart';

@immutable
sealed class AuthFlowEvent {}
class LogEventHandler extends AuthFlowEvent {
  final String email;
  final String password;
  LogEventHandler({required this.email, required this.password});
}
