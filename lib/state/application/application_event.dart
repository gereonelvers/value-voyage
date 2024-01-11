part of 'application_bloc.dart';

@immutable
abstract class ApplicationEvent {}

// This is bad lmao
class UpdateScreenEvent implements ApplicationEvent {}
