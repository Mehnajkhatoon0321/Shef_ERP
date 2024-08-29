import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:shef_erp/utils/api_constant.dart';
import 'package:shef_erp/utils/connectivity_service.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
part 'auth_flow_event.dart';
part 'auth_flow_state.dart';

class AuthFlowBloc extends Bloc<AuthFlowEvent, AuthFlowState> {
  AuthFlowBloc() : super(AuthFlowInitial()) {
    on<AuthFlowEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LogEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(AuthFlowLoading());
        try {
          final requestData = json.encode({
            "email": event.email,
            "password": event.password,
          });

          developer.log("Requesting login: ${Uri.parse(APIEndPoints.login)}");

          var response = await http.post(
            Uri.parse(APIEndPoints.login),
            headers: {'Content-Type': 'application/json'},
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            if (responseData.containsKey("token")) {
              var token = responseData["token"];
              PrefUtils.setToken(token);
              emit(LogSuccess(responseData));
              developer.log("Login successful: ${responseData.runtimeType}");
            } else if (response.statusCode == 400) {
              emit(LogFailure(jsonDecode(response.body)["message"]));
              developer.log("Login LogFailure: ${responseData.runtimeType}");
            }
            else if (response.statusCode == 401) {
              emit(LogFailure(jsonDecode(response.body)["message"]));
              developer.log("Login LogFailure: ${responseData.runtimeType}");
            }
            else if (response.statusCode == 500) {
              emit(LogFailure(jsonDecode(response.body)["message"]));
            } else {
              emit(LogFailure("Unexpected response format"));
            }
          }
          else {
            String errorMessage;
            try {
              final errorData = jsonDecode(response.body);
              errorMessage = errorData["message"] ?? "An error occurred";
            } catch (_) {
              errorMessage = "An error occurred";
            }
            emit(LogFailure(errorMessage));
          }
        } catch (e) {
          if (kDebugMode) {
            emit(AuthFlowServerFailure(e.toString()));
            developer.log("Error during login: ${e.toString()}");
          }
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });
  }

}
