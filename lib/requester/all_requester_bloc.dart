import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shef_erp/utils/api_constant.dart';
import 'package:shef_erp/utils/connectivity_service.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
part 'all_requester_event.dart';
part 'all_requester_state.dart';

class AllRequesterBloc extends Bloc<AllRequesterEvent, AllRequesterState> {
  AllRequesterBloc() : super(AllRequesterInitial()) {
    on<AllRequesterEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<AddCartDetailHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(AddCartLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.requesterList}$userId?page=${event.page}&per_page=${event.size}");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $APIEndpoint");
          if (response.statusCode == 200) {
            print('response.statusCode_in>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(AddCartSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(AddCartFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(AddCartFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(AddCartFailure(const {'error': 'Network error'}));
      }
    });
    //RequesterList
    on<RequesterHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ViewAddListLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.requesterListAdd}$userId");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $APIEndpoint");
          if (response.statusCode == 200) {
            print('response.statusCode_in>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(ViewAddListSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(AddCartFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(AddCartFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(AddCartFailure(const {'error': 'Network error'}));
      }
    });

// ProductList
    on<ProductListHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ProductListLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getProduct}");
          final requestBody = jsonEncode({
            'cat_id': event.categoryID,
            'user_id': userId,
          });

          var response = await http.post(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestBody,
          );

          developer.log("URL: $APIEndpoint");
          if (response.statusCode == 200) {
            print('response.statusCode_in>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(ProductListSuccess(responseData));
          } else {
            final responseError = jsonDecode(response.body);
            emit(AddCartFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(AddCartFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(AddCartFailure(const {'error': 'Network error'}));
      }
    });

    //Specification

    on<SepListHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(SpecificationListLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getSpecification}");
          final requestBody = jsonEncode({
            'pid': event.productID,
            'user_id': userId,
          });

          var response = await http.post(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestBody,
          );

          developer.log("URL: $APIEndpoint");
          if (response.statusCode == 200) {
            print('response.statusCode_in>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(SpecificationListSuccess(responseData));
          } else {
            final responseError = jsonDecode(response.body);
            emit(AddCartFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(AddCartFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(AddCartFailure(const {'error': 'Network error'}));
      }
    });


  }
}
