import 'dart:convert';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:shef_erp/utils/api_constant.dart';
import 'package:shef_erp/utils/connectivity_service.dart';
import 'package:shef_erp/utils/pref_utils.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import 'package:path/path.dart' as path;
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
          if (kDebugMode) {
            print('Exception: $e');
          }
          emit(AddCartFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        if (kDebugMode) {
          print('Network error');
        }
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

//     on<AddRequisitionHandler>((event, emit) async {
//       if (await ConnectivityService.isConnected()) {
//         emit(AddRequisitionLoading());
//         try {
//           Dio dio = Dio();
//           String authToken = PrefUtils.getToken();
//           dio.options.headers["Authorization"] = 'Bearer $authToken';
//
//           // Prepare the list of files
//           List<MultipartFile> files = [];
//           for (var item in event.requisitionList) {
//             String filePath = item['image']!.path;
//             String fileName = basename(filePath);
//             files.add(await MultipartFile.fromFile(filePath, filename: fileName));
//           }
//
//           // Prepare FormData
//           Map<String, dynamic> formDataMap = {
//             'files': files,
//             'date': event.date,
//             'unit': event.unit,
//             'time': event.time,
//             'user_id': PrefUtils.getUserId(),
//           };
//
//           // Add requisition list items to formDataMap
//           for (int i = 0; i < event.requisitionList.length; i++) {
//             formDataMap['requisition_list[$i][product]'] = event.requisitionList[i]['product'];
//             formDataMap['requisition_list[$i][specification]'] = event.requisitionList[i]['specification'];
//             formDataMap['requisition_list[$i][event]'] = event.requisitionList[i]['event'];
//             formDataMap['requisition_list[$i][additional]'] = event.requisitionList[i]['additional'];
//             formDataMap['requisition_list[$i][quantity]'] = event.requisitionList[i]['quantity'];
//             formDataMap['requisition_list[$i][user_id]'] = event.requisitionList[i]['user_id'];
//           }
//
//           FormData requestbody = FormData.fromMap(formDataMap);
//           var response = await dio.post(APIEndPoints.postRequisition, data: requestbody);
//
//           if (response.statusCode == 200) {
//             emit(AddRequisitionSuccess(response.data));
// print(">>>>>ALl${response.data}");
//           } else {
//             emit(AddCartFailure(const {'error': 'Exception occurred:'}));
//           }
//         } on DioException catch (e) {
//           if (e.response != null) {
//             emit(AddCartFailure(const {'error': 'Exception occurred:'}));
//           } else {
//             emit(AddCartFailure(const {'error': 'Exception occurred:'}));
//           }
//           if (kDebugMode) {
//             developer.log(e.toString());
//           }
//         } catch (e) {
//           if (kDebugMode) {
//             developer.log(e.toString());
//           }
//         }
//       } else {
//         emit(AddCartFailure(const {'error': 'Exception occurred:'}));
//       }
//     });
    on<AddRequisitionHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(AddRequisitionLoading());
        try {
          Dio dio = Dio();
          String authToken = PrefUtils.getToken();
          dio.options.headers["Authorization"] = 'Bearer $authToken';

// Prepare FormData with proper field names
          FormData formData = FormData.fromMap({
            'date': event.date,
            'unit': event.unit,
            'time': event.time,
            'delivery_date':event.nextDate,
            'user_id': PrefUtils.getUserId(),
          });

// Prepare requisition list and attach files
          for (int i = 0; i < event.requisitionList.length; i++) {
            var item = event.requisitionList[i];
            String filePath = item['image']?.path ?? '';

            // Add each requisition field to FormData
            formData.fields.addAll([
              MapEntry('requisition_list[$i][product]', item['product'] ?? ''),
              MapEntry('requisition_list[$i][specification]', item['specification'] ?? ''),
              MapEntry('requisition_list[$i][event]', item['event'] ?? ''),
              MapEntry('requisition_list[$i][additional]', item['additional'] ?? ''),
              MapEntry('requisition_list[$i][quantity]', item['quantity']?.toString() ?? ''),
              MapEntry('requisition_list[$i][user_id]', item['user_id']?.toString() ?? ''),
            ]);

            // Attach image file if present
            if (filePath.isNotEmpty) {
              File file = File(filePath);
              if (await file.exists()) {
                String fileName = basename(filePath);
                formData.files.add(MapEntry(
                  'requisition_list[$i][image]',
                  await MultipartFile.fromFile(filePath, filename: fileName),
                ));
              } else {
                emit(AddCartFailure({'error': 'File not found: $filePath'}));
                return;
              }
            } else {
              emit(AddCartFailure({'error': 'Invalid file path'}));
              return;
            }
          }
              print(">>>>>Imaage");
// Send the request
          var response = await dio.post(APIEndPoints.postRequisition, data: formData);

          if (response.statusCode == 200) {
            emit(AddRequisitionSuccess(response.data));
            print(">>>>> Response: ${response.data}");
          }else if   (response.statusCode == 400) {
            emit(AddCartFailure(response.data));
            print(">>>>> Response: ${response.data}");
          }
          else if   (response.statusCode == 500) {
            emit(AddCartFailure(response.data));
            print(">>>>> Response: ${response.data}");
          }  else {
            emit(AddCartFailure({'error': 'Failed to upload requisition'}));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(AddCartFailure({'error': 'Exception occurred: ${e.toString()}'}));
        }
      } else {
        emit(AddCartFailure({'error': 'No internet connection'}));
      }
    });
    //Delete Requisition

    on<DeleteHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(DeleteLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.postDelete}${event.ID}/$userId");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $response");

          if (response.statusCode == 200) {
            print('response.statusCode_in>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(DeleteSuccess(responseData));


          }
          else {
            final responseError = jsonDecode(response.body);
            emit(DeleteFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(DeleteFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(DeleteFailure( {'error': 'Network error'}));
      }
    });

    //Edit Requisition Details

    on<EditDetailHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(EditLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.postReqEdit}${event.id}/$userId");
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
            emit(EditSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(EditSuccessFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(EditSuccessFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(EditSuccessFailure(const {'error': 'Network error'}));
      }
    });
//Update Requisition
    on<UpdateRequisitionEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UpdateLoading());
        try {
          Dio dio = Dio();
          String authToken = PrefUtils.getToken();
          var headers = {
            "Authorization": 'Bearer $authToken',
          };

          var formData = FormData.fromMap({
            'date': event.date,
            'unit': event.unit,
            'time': event.time,
            'product': event.product,
            'specification': event.specification,
            'user_id': event.userid,
            'quantity': event.quantity,
            'additional': event.additional,
            'event': event.event,
            'delivery_date': event.delivery_date,
            'pre_img': event.preImg,
            'req_id': event.reqID,
            if (event.Image != null)
              'image': await MultipartFile.fromFile(event.Image!.path)
          });

          var response = await dio.post(APIEndPoints.postReqUpdate,
              data: formData,
              options: Options(headers: headers)
          );

          if (response.statusCode == 200) {
            emit(UpdateSuccess(response.data));
          } else {
            emit(UpdateFailure(response.data));
          }
        } catch (e) {
          emit(UpdateFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        emit(UpdateFailure({'error': 'No internet connection'}));
      }
    });


//Get Unit
    on<GetUnitHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UnitLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getUnits}/$userId?page=${event.page}&per_page=${event.size}");
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
            emit(UnitSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(UnitFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(UnitFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(UnitFailure(const {'error': 'Network error'}));
      }
    });
//Delete

    on<DeleteUnitHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UnitDeleteLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.deleteUnits}${event.id}");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $response");

          if (response.statusCode == 200) {
            print('response>>>>>>>>>>>>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(UnitDeleteSuccess(responseData));


          }
          else {
            final responseError = jsonDecode(response.body);
            emit(UnitDeleteFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(UnitDeleteFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(UnitDeleteFailure( {'error': 'Network error'}));
      }
    });

    //Create Unit
    on<UnitCreateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UnitCreateLoading());
        try {
          final requestData = json.encode({
            "billing_name": event.billingAddress,
            "address": event.address,
            "name": event.address,
          });

          developer.log("Requesting login: ${Uri.parse(APIEndPoints.login)}");

          var response = await http.post(
            Uri.parse(APIEndPoints.createUnits),
            headers: {'Content-Type': 'application/json'},
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            if (responseData.containsKey("token")) {
              var token = responseData["token"];
              PrefUtils.setToken(token);
              emit(UnitCreateSuccess(responseData));
              developer.log("Create successful: ${responseData.runtimeType}");
            } else if (response.statusCode == 400) {
              emit(UnitCreateFailure(jsonDecode(response.body)["message"]));
              developer.log("Create LogFailure: ${responseData.runtimeType}");
            }
            else if (response.statusCode == 401) {
              emit(UnitCreateFailure(jsonDecode(response.body)["message"]));
              developer.log("Login LogFailure: ${responseData.runtimeType}");
            }
            else if (response.statusCode == 500) {
              emit(UnitCreateFailure(jsonDecode(response.body)["message"]));
            } else {
              emit(UnitCreateFailure("Unexpected response format"));
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
            emit(UnitCreateFailure(errorMessage));
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
