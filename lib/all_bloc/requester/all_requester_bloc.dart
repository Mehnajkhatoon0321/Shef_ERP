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
              emit(AddCartFailure(const {'error': 'Invalid file path'}));
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
            emit(AddCartFailure(const {'error': 'Failed to upload requisition'}));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(AddCartFailure({'error': 'Exception occurred: ${e.toString()}'}));
        }
      } else {
        emit(AddCartFailure(const {'error': 'No internet connection'}));
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
        emit(DeleteFailure( const {'error': 'Network error'}));
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
        emit(UpdateFailure(const {'error': 'No internet connection'}));
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
        emit(UnitDeleteFailure( const {'error': 'Network error'}));
      }
    });

    //Create Unit
    on<UnitCreateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(UnitCreateLoading());
        try {
          final requestData = json.encode({
            "billing_name": event.billingAddress,
            "address": event.address,
            "name": event.name,
          });

          developer.log("Requesting create: ${Uri.parse(APIEndPoints.createUnits)}");

          var response = await http.post(
            Uri.parse(APIEndPoints.createUnits),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(UnitCreateSuccess(responseData));

          } else {
            String errorMessage;
            try {
              final errorData = jsonDecode(response.body);
              errorMessage = errorData["message"] ?? "An error occurred";
            } catch (_) {
              errorMessage = "An error occurred";
            }
            emit(UnitCreateFailure(errorMessage));
            developer.log("Create failure: ${response.statusCode} - $errorMessage");
          }
        } catch (e) {
          if (kDebugMode) {
            emit(AuthFlowServerFailure(e.toString()));
            developer.log("Error during unit creation: ${e.toString()}");
          }
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

    //Update
    on<UnitUpdateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UnitCreateLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.updateUnits),
          );
print("RequestData>>>>>>>>>>$request");
          request.fields.addAll({
            'billing_name': event.billingAddress,
            'address': event.address,
            'name': event.name,
            'id': event.id,
          });

          request.headers.addAll(headers);

          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          developer.log("Response status: ${response.statusCode}");
          developer.log(" Update$responseData");

          if (response.statusCode == 200) {
            emit(UnitUpdateSuccess(jsonDecode(responseData)));
          } else {

            emit(UnitUpdateFailure(responseData));
            developer.log("Update failure: ${response.statusCode} - $responseData");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during unit update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });


//GetProduct Category
    on<GetProductCategoryHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ServiceCategoryLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.productGetCategory}$userId?page=${event.page}&per_page=${event.size}");
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
            emit(ServiceCategorySuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(ServiceCategoryFailure(responseError));
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

//delete category

    on<DeleteMasterCategoryHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        int userId = PrefUtils.getUserId();
        emit(DeleteServiceCategoryLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.productGetCategoryDelete}${event.id}/$userId");
          developer.log("Making DELETE request to: $APIEndpoint");
          developer.log("Authorization Token: $authToken");

          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
          );

          // Log response details
          developer.log("Response status: ${response.statusCode}");
          developer.log("Response body: ${response.body}");

          if (response.statusCode == 200) {
            print('Response successful: ${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(DeleteServiceCategorySuccess(responseData));
          }

          else {
            final responseError = jsonDecode(response.body);
            emit(DeleteEventCategoryFailure(responseError));
            developer.log("Error response: ${responseError}");
          }
        } catch (e) {
          print('Exception: $e');
          emit(DeleteEventCategoryFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(DeleteEventCategoryFailure(const {'error': 'Network error'}));
      }
    });

//create category

    on<CategoryCreateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(CreateCategoryLoading());

        try {
          final requestData = json.encode({
            "cate_name": event.category,
          });

          developer.log(
              "Requesting create: ${Uri.parse(APIEndPoints.productGetCategoryCreate)}");

          final response = await http.post(
            Uri.parse(APIEndPoints.productGetCategoryCreate),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(CreateCategorySuccess(responseData));
          } else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(CreateCategoryFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(CreateCategoryFailure(responseError));
          } else {
            emit(CreateCategoryFailure('Failed to upload requisition'));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(CreateCategoryFailure('Exception occurred: ${e.toString()}'));
        }
      } else {
        emit(CreateCategoryFailure('No internet connection'));
      }

    });

//Edit Category

    on<CategoryUpdateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(UpdateCategoryLoading());

        try {
          final requestData = json.encode({
            "cate_name": event.category,
            "user_id": event.userId,
            "id": event.id,
          });

          developer.log(
              "Requesting update: ${Uri.parse(APIEndPoints.productCategoryUpdate)}");


          print("requestData>>>>>${requestData}");
          final response = await http.post(
            Uri.parse(APIEndPoints.productCategoryUpdate),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(UpdateCategorySuccess(responseData));
          } else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(UpdateCategoryFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(UpdateCategoryFailure(responseError));
          } else {
            emit(UpdateCategoryFailure(const {'error': 'Exception occurred: '}));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(UpdateCategoryFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        emit(UpdateCategoryFailure(const {'error':'No internet connection'}));
      }

    });


    //get user List
    on<GetUserListHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UnitLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getUserList}$userId?page=${event.page}&per_page=${event.size}");
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
            emit(GetUserListSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(GetUserListFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(GetUserListFailure('Exception occurred'));
        }
      } else {
        print('Network error');
        emit(UnitFailure(const {'error': 'Network error'}));
      }
    });
    //get billing address

    //delete user list id

    on<DeleteUserIDHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UserDeleteLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.deleteUserList}${event.id}");
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
            emit(UserDeleteSuccess(responseData));


          }
          else {
            final responseError = jsonDecode(response.body);
            emit(UserDeleteFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(UserDeleteFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(UserDeleteFailure( const {'error': 'Network error'}));
      }
    });

    //Edit Details

    on<EditDetailUserHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UserEditDetailsLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.editDetailsUserList}${event.id}");
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
            emit(UserEditDetailsSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(UserEditDetailsFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(UserEditDetailsFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(UserEditDetailsFailure(const {'error': 'Network error'}));
      }
    });

    //user update
    on<UserUpdateEventHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(UserUpdateLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.updateDetailsUserList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'name': event.name,
            'email': event.email,
            'contact': event.contact,
            'address': event.address,
            'designation': event.designation,
            'password': event.password,
            'roles': event.role,
            'id': event.id,
            'unitid': event.unitID,
          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(UserUpdateSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(UserUpdateFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });
    //user create

    on<UserCreateEventHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(UserCreateLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.createDetailsUserList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'name': event.name,
            'email': event.email,
            'contact': event.contact,
            'address': event.address,
            'designation': event.designation,
            'password': event.password,
            'roles': event.role,
            'id': event.id,
            'unitid': event.unitID,
          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(UserCreateSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(UserCreateFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });


    //billing in master section
    on<GetBillingListHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UserBillingLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getBillingList}$userId?page=${event.page}&per_page=${event.size}");
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
            emit(UserBillingSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(BillingFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(BillingFailure(const {'error': 'Network error'}));
        }
      } else {
        print('Network error');
        emit(BillingFailure(const {'error': 'Network error'}));
      }
    });


    //delete
    on<DeleteBillingHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(UserBillingDeleteLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.deleteBillingList}${event.id}");

          print(">>>>>ApiUrl deleteBilling>>>>$APIEndpoint");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $response");
          print(">>>>>Response deleteBilling>>>>$APIEndpoint");

          if (response.statusCode == 200) {
            print('response>>>>>>>>>>>>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(UserBillingDeleteSuccess(responseData));
            print(">>>>>Response deleteBilling>>>>$responseData");

          }
          else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(UserBillingDeleteFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(UserBillingDeleteFailure(responseError));
          }
          else {
            final responseError = jsonDecode(response.body);
            emit(UserBillingDeleteFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(UserBillingDeleteFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(UserBillingDeleteFailure( const {'error': 'Network error'}));
      }
    });

    //billing create
    on<BillingCreateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(BillingCreateLoading());
        try {
          final requestData = json.encode({
            "billing_name": event.billingAddress,
            "address": event.address,

          });

          developer.log("Requesting create: ${Uri.parse(APIEndPoints.createBillingList)}");

          var response = await http.post(
            Uri.parse(APIEndPoints.createBillingList),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(BillingCreateSuccess(responseData));

          } else {
            String errorMessage;
            try {
              final errorData = jsonDecode(response.body);
              errorMessage = errorData["message"] ?? "An error occurred";
            } catch (_) {
              errorMessage = "An error occurred";
            }
            emit(BillingCreateFailure(errorMessage));
            developer.log("Create failure: ${response.statusCode} - $errorMessage");
          }
        } catch (e) {
          if (kDebugMode) {
            emit(BillingCreateFailure(e.toString()));
            developer.log("Error during unit creation: ${e.toString()}");
          }
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

    //Update
    on<BillingUpdateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(BillingCreateLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.updateBillingList),
          );
          print("RequestData>>>>>>>>>>$request");
          request.fields.addAll({
            'billing_name': event.billingAddress,
            'address': event.address,

            'id': event.id,
          });

          request.headers.addAll(headers);

          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          developer.log("Response status: ${response.statusCode}");
          developer.log(" Update$responseData");

          if (response.statusCode == 200) {
            emit(BillingUpdateSuccess(jsonDecode(responseData)));
          } else {

            emit(BillingUpdateFailure(responseData));
            developer.log("Update failure: ${response.statusCode} - $responseData");
          }
        } catch (e) {
          emit(BillingUpdateFailure(e.toString()));
          developer.log("Error during unit update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

       //product Service list

    on<MasterServiceHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ServiceLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getProductList}$userId?page=${event.page}&per_page=${event.size}");
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
            emit(ServiceSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(ServiceFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(ServiceFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(ServiceFailure(const {'error': 'Network error'}));
      }
    });


    //product delete

    on<DeleteMasterServiceHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(DeleteServiceLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();

          final APIEndpoint = Uri.parse("${APIEndPoints.deleteProductList}$userId/${event.id}");

          print(">>>>>ApiUrl deleteBilling>>>>$APIEndpoint");
          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',

            },
          );
          developer.log("URL: $response");
          print(">>>>>Response deleteBilling>>>>$APIEndpoint");

          if (response.statusCode == 200) {
            print('response>>>>>>>>>>>>${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(DeleteServiceSuccess(responseData));
            print(">>>>>Response deleteBilling>>>>$responseData");

          }
          else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(DeleteEventServiceFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(DeleteEventServiceFailure(responseError));
          }
          else {
            final responseError = jsonDecode(response.body);
            emit(DeleteEventServiceFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(DeleteEventServiceFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(DeleteEventServiceFailure( const {'error': 'Network error'}));
      }
    });


//product edit

    on<ProductEditDetailUserHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ProductEditDetailsLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.EditList}${event.id}");
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
            emit(ProductEditSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(ProductEditFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(ProductEditFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(ProductEditFailure(const {'error': 'Network error'}));
      }
    });

    //product create

    on<ProductListUserHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(ProductEditListLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getEditList}/$userId");
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
            emit(ProductEditListSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(ProductEditListFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(ProductEditListFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(ProductEditListFailure(const {'error': 'Network error'}));
      }
    });

    //create product post api
    on<ProductCreateEventHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(CreateProductLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.createProductList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'name': event.name,
            'cate': event.cateName,
            'specification': event.specification,
            'user_id': event.user_id,


          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(CreateProductSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(CreateProductFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

    //product update
    on<ProductUpdateEventHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(UpdateProductLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.updateProductList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'name': event.name,
            'cate': event.cateName,
            'specification': event.specification,
            'user_id': event.user_id,


          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(UpdateProductSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(UpdateProductFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

    //status product


    on<ProductStatusHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(StatusLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.getStatusProductList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'id': event.id,


          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(StatusSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(StatusFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });
//status change


    on<ProductStatusChangeHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(StatusChangeLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.getStatusChangeProductList),
          );

          // Log the request details for debugging
          developer.log("Request Data: ${request.toString()}");

          // Add fields to the request
          request.fields.addAll({
            'id': event.id,
            'user_id':event.userID,
            'status':event.status
          });

          // Add headers to the request
          request.headers.addAll(headers);

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Update response: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(StatusChangeSuccess(jsonDecode(responseData)));
          } else {
            // Assuming the error response format is JSON
            final responseError = jsonDecode(responseData);
            emit(StatusChangeFailure(responseError));
            developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });

    //vendor action
    on<VendorActionHandler>((event, emit) async {
      // Check for internet connectivity
      if (await ConnectivityService.isConnected()) {
        emit(VendorAssignLoading());

        try {
          String authToken = PrefUtils.getToken();
          var headers = {
            'Authorization': 'Bearer $authToken',
          };

          var request = http.MultipartRequest(
            'POST',
            Uri.parse(APIEndPoints.actionVendor),
          );

          // Log the request details for debugging
          developer.log("Request URL: ${request.url}");
          developer.log("Request Method: ${request.method}");

          // Prepare fields to add to the request
          var fields = {
            'userRole': event.userRole,
            'user_id': event.userID,
            'count': event.count,
            'btnAssign': event.btnAssign,
            'vendor': event.vendor,
            'billing': event.billing,
          };

          // Check if event.allCount is not empty
          if (event.allCount.isNotEmpty) {
            for (int i = 0; i < event.allCount.length; i++) {
              fields['allCount[$i]'] = event.allCount[i].toString();
            }
          } else {
            developer.log("Warning: event.allCount is empty.");
          }

          // Add fields to the request
          request.fields.addAll(fields);

          // Add headers to the request
          request.headers.addAll(headers);

          // Log the complete request details
          developer.log("Request Fields: ${request.fields}");
          developer.log("Request Headers: ${request.headers}");

          // Send the request
          final response = await request.send();
          final responseData = await response.stream.bytesToString();

          // Log the response status and data
          developer.log("Response status: ${response.statusCode}");
          developer.log("Response data: $responseData");

          // Handle the response based on status code
          if (response.statusCode == 200) {
            emit(VendorAssignSuccess(jsonDecode(responseData)));
          } else {
            // Handle error responses
            try {
              final responseError = jsonDecode(responseData);
              emit(VendorAssignFailure(responseError));
              developer.log("Update failure: ${response.statusCode} - ${responseError['message'] ?? responseData}");
            } catch (e) {
              emit(VendorAssignFailure(const {'message': 'Failed to process server response.'}));
              developer.log("Failed to decode error response: ${e.toString()} - Response data: $responseData");
            }
          }
        } catch (e) {
          emit(AuthFlowServerFailure(e.toString()));
          developer.log("Error during user update: ${e.toString()}");
        }
      } else {
        emit(CheckNetworkConnection("No internet connection"));
      }
    });
    //Event list
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//Get event
    on<EventListHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        emit(EventListLoading());
        try {
          String authToken = PrefUtils.getToken();
          int userId = PrefUtils.getUserId();
          final APIEndpoint = Uri.parse("${APIEndPoints.getEventsList}$userId?page=${event.page}&per_page=${event.size}");
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
            emit(EventListSuccess(responseData));

          }
          else {
            final responseError = jsonDecode(response.body);
            emit(EventListFailure(responseError));
          }
        } catch (e) {
          print('Exception: $e');
          emit(EventListFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(EventListFailure(const {'error': 'Network error'}));
      }
    });

//delete event

    on<DeleteEventHandlers>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        int userId = PrefUtils.getUserId();
        emit(EventDeleteLoading());
        try {
          String authToken = PrefUtils.getToken();

          final APIEndpoint = Uri.parse("${APIEndPoints.deleteEventList}${event.id}/$userId");
          developer.log("Making DELETE request to: $APIEndpoint");
          developer.log("Authorization Token: $authToken");

          var response = await http.get(
            APIEndpoint,
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
          );

          // Log response details
          developer.log("Response status: ${response.statusCode}");
          developer.log("Response body: ${response.body}");

          if (response.statusCode == 200) {
            print('Response successful: ${response.statusCode}');
            final responseData = jsonDecode(response.body);
            emit(EventDeleteSuccess(responseData));
          }

          else {
            final responseError = jsonDecode(response.body);
            emit(EventDeleteFailure(responseError));
            developer.log("Error response: ${responseError}");
          }
        } catch (e) {
          print('Exception: $e');
          emit(EventDeleteFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        print('Network error');
        emit(EventDeleteFailure(const {'error': 'Network error'}));
      }
    });

//create event

    on<CreateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(EventCreateLoading());

        try {
          final requestData = json.encode({
            "cate_name": event.category,
          });

          developer.log(
              "Requesting create: ${Uri.parse(APIEndPoints.createEventList)}");

          final response = await http.post(
            Uri.parse(APIEndPoints.createEventList),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(EventCreateSuccess(responseData));
          } else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(EventCreateFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(EventCreateFailure(responseError));
          } else {
            emit(EventCreateFailure('Failed to upload requisition'));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(EventCreateFailure('Exception occurred: ${e.toString()}'));
        }
      } else {
        emit(EventCreateFailure('No internet connection'));
      }

    });

//Edit event

    on<UpdateEventHandler>((event, emit) async {
      if (await ConnectivityService.isConnected()) {
        String authToken = PrefUtils.getToken();
        emit(UpdateEventsLoading());

        try {
          final requestData = json.encode({
            "cate_name": event.category,
            "user_id": event.userId,
            "id": event.id,
          });

          developer.log(
              "Requesting update: ${Uri.parse(APIEndPoints.updateEventList)}");


          print("requestData>>>>>${requestData}");
          final response = await http.post(
            Uri.parse(APIEndPoints.updateEventList),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $authToken',
            },
            body: requestData,
          );

          if (response.statusCode == 200) {
            final responseData = jsonDecode(response.body);
            emit(UpdateEventsSuccess(responseData));
          } else if (response.statusCode == 401) {
            final responseError = jsonDecode(response.body);
            emit(UpdateEventsFailure(responseError));
          }
          else if (response.statusCode == 500) {
            final responseError = jsonDecode(response.body);
            emit(UpdateEventsFailure(responseError));
          } else {
            emit(UpdateEventsFailure(const {'error': 'Exception occurred: '}));
          } // Print request details

        } catch (e) {
          if (kDebugMode) {
            developer.log(e.toString());
          }
          emit(UpdateEventsFailure({'error': 'Exception occurred: $e'}));
        }
      } else {
        emit(UpdateEventsFailure(const {'error':'No internet connection'}));
      }

    });

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++



  }
}
