import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'complaint_event.dart';
import 'complaint_state.dart';

class ComplaintBloc extends Bloc<ComplaintEvent, ComplaintState> {
  ComplaintBloc() : super(ComplaintInitial()) {
    on<FetchComplaints>(_onFetchComplaints);
  }

  Future<void> _onFetchComplaints(
      FetchComplaints event, Emitter<ComplaintState> emit) async {
    emit(ComplaintLoading());
    try {
      final response = await http.get(Uri.parse(
          'https://brownonions-002-site2.ftempurl.com/api/Complaint/GetComplaints?ComplaintId=-1&ChefId=3&UserId=-1&StatusId=-1&ComplaintTypeId=-1&FromComplaint=chef'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        if (responseData.containsKey('data') && responseData['data'] is List) {
          emit(ComplaintLoaded(responseData['data']));
        } else {
          emit(ComplaintError('Unexpected response format'));
        }
      } else {
        emit(ComplaintError('Failed to fetch complaints: ${response.body}'));
      }
    } catch (error) {
      emit(ComplaintError('An error occurred: $error'));
    }
  }
}
