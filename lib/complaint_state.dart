abstract class ComplaintState {}

class ComplaintInitial extends ComplaintState {}

class ComplaintLoading extends ComplaintState {}

class ComplaintLoaded extends ComplaintState {
  final List complaints;

  ComplaintLoaded(this.complaints);
}

class ComplaintError extends ComplaintState {
  final String message;

  ComplaintError(this.message);
}
