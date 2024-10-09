part of 'all_requester_bloc.dart';

@immutable
sealed class AllRequesterState {}

final class AllRequesterInitial extends AllRequesterState {}
final class AddCartLoading extends AllRequesterState{}
final class PreviewCartLoading extends AllRequesterState{}


final class AddCartSuccess extends AllRequesterState{
  final Map<String, dynamic> addCartDetails;
  AddCartSuccess(this.addCartDetails);

}
final class AddCartFailure extends AllRequesterState{
  final Map<String, dynamic> addCartDetailFailure;
  AddCartFailure(this.addCartDetailFailure);

}

final class ServerFailure extends AllRequesterState{
  final Map<String, dynamic> serverFailure;
  ServerFailure(this.serverFailure);

}
//View Add List
final class ViewAddListLoading extends AllRequesterState{}
final class ViewAddListSuccess extends AllRequesterState{
  final Map<String, dynamic> viewAddList;
  ViewAddListSuccess(this.viewAddList);
//


}
//Product List
final class ProductListLoading extends AllRequesterState{}
final class ProductListSuccess extends AllRequesterState {
  final Map<String, dynamic> productList;

  ProductListSuccess(this.productList);



}
//Specification List
final class SpecificationListLoading extends AllRequesterState{}
final class SpecificationListSuccess extends AllRequesterState{
  final Map<String, dynamic> specList;
  SpecificationListSuccess(this.specList);
// Add Requisition


}

// AllRequesterState
final class AddRequisitionLoading extends AllRequesterState{}
final class AddRequisitionSuccess extends AllRequesterState{
  final Map<String, dynamic> addRequisition;
  AddRequisitionSuccess(this.addRequisition);
// Add Requisition


}

//Delete Requisition

final class DeleteLoading extends AllRequesterState{}
final class DeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteList;
  DeleteSuccess(this.deleteList);

}


final class DeleteFailure extends AllRequesterState{
  final Map<String, dynamic> deleteAddressFailure;
  DeleteFailure(this.deleteAddressFailure);

}
//
final class EditLoading extends AllRequesterState{}
final class EditSuccess extends AllRequesterState{
  final Map<String, dynamic> editList;
  EditSuccess(this.editList);

}


final class EditSuccessFailure extends AllRequesterState{
  final Map<String, dynamic> deleteAddressFailure;
  EditSuccessFailure(this.deleteAddressFailure);

}


final class UpdateLoading extends AllRequesterState{}
final class UpdateSuccess extends AllRequesterState{
  final Map<String, dynamic> updateList;
  UpdateSuccess(this.updateList);

}


final class UpdateFailure extends AllRequesterState{
  final Map<String, dynamic> updateFailure;
  UpdateFailure(this.updateFailure);

}



//Mark And Delivery

final class MarkLoading extends AllRequesterState{}
final class MarkSuccess extends AllRequesterState{
  final Map<String, dynamic> markList;
  MarkSuccess(this.markList);

}


final class MarkFailure extends AllRequesterState{
  final Map<String, dynamic> markFailure;
  MarkFailure(this.markFailure);

}
//Service in Admin


final class ServiceLoading extends AllRequesterState{}
final class ServiceSuccess extends AllRequesterState{
  final Map<String, dynamic> serviceList;
  ServiceSuccess(this.serviceList);

}


final class ServiceFailure extends AllRequesterState{
  final Map<String, dynamic> serviceFailure;
  ServiceFailure(this.serviceFailure);

}

final class DeleteServiceLoading extends AllRequesterState{}
final class DeleteServiceSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteServiceList;
  DeleteServiceSuccess(this.deleteServiceList);

}


final class DeleteEventServiceFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEventServiceFailure;
  DeleteEventServiceFailure(this.deleteEventServiceFailure);

}
final class EditEventServiceLoading extends AllRequesterState{}
final class EditEventServiceSuccess extends AllRequesterState{
  final Map<String, dynamic> editEventServiceList;
  EditEventServiceSuccess(this.editEventServiceList);

}


final class EditSuccessEventServiceFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEventServiceFailure;
  EditSuccessEventServiceFailure(this.deleteEventServiceFailure);

}




//Service and category
//
//
final class ServiceCategoryLoading extends AllRequesterState{}
final class ServiceCategorySuccess extends AllRequesterState{
  final Map<String, dynamic> serviceCategoryList;
  ServiceCategorySuccess(this.serviceCategoryList);

}


final class  ServiceCategoryFailure extends AllRequesterState{
  final Map<String, dynamic> serviceCategoryFailure;
  ServiceCategoryFailure(this.serviceCategoryFailure);

}

final class DeleteServiceCategoryLoading extends AllRequesterState{}
final class DeleteServiceCategorySuccess extends AllRequesterState{
  final Map<String, dynamic> deleteEventCategoryList;
  DeleteServiceCategorySuccess(this.deleteEventCategoryList);

}


final class DeleteEventCategoryFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEventCategoryFailure;
  DeleteEventCategoryFailure(this.deleteEventCategoryFailure);

}

//Event Category
final class EditEventCategoryLoading extends AllRequesterState{}
final class EditEventCategorySuccess extends AllRequesterState{
  final Map<String, dynamic> editEventCategoryList;
  EditEventCategorySuccess(this.editEventCategoryList);

}


final class EditSuccessEventCategoryFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEventCategoryFailure;
  EditSuccessEventCategoryFailure(this.deleteEventCategoryFailure);

}





final class  EventFailure extends AllRequesterState{
  final Map<String, dynamic> eventFailure;
  EventFailure(this.eventFailure);

}



//Get UNit

final class UnitLoading extends AllRequesterState{}
final class  UnitSuccess extends AllRequesterState{
  final Map<String, dynamic> UnitList;
  UnitSuccess(this.UnitList);

}


final class  UnitFailure extends AllRequesterState{
  final Map<String, dynamic> unitFailure;
  UnitFailure(this.unitFailure);

}

final class UnitDeleteLoading extends AllRequesterState{}
final class  UnitDeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> unitDeleteList;
  UnitDeleteSuccess(this.unitDeleteList);

}


final class  UnitDeleteFailure extends AllRequesterState{
  final Map<String, dynamic> deleteUnitFailure;
  UnitDeleteFailure(this.deleteUnitFailure);

}

//create
final class  UnitCreateLoading extends AllRequesterState {}

final class  UnitCreateSuccess extends AllRequesterState {
  final Map<String ,dynamic> createResponse;
  UnitCreateSuccess(this.createResponse);

}
final class UnitCreateFailure extends AllRequesterState {

  final String failureMessage;
  UnitCreateFailure(this.failureMessage);

}


final class AuthFlowServerFailure extends AllRequesterState {
  final String error;
  AuthFlowServerFailure(this.error);

}


class CheckNetworkConnection extends AllRequesterState {
  final String errorMessage;
  CheckNetworkConnection(this.errorMessage);
}
final class  UnitUpdateSuccess extends AllRequesterState {
  final Map<String ,dynamic> updateResponse;
  UnitUpdateSuccess(this.updateResponse);

}
final class UnitUpdateFailure extends AllRequesterState {

  final String failureMessage;
  UnitUpdateFailure(this.failureMessage);

}
//create category
final class CreateCategoryLoading extends AllRequesterState{}
final class  CreateCategorySuccess extends AllRequesterState {
  final Map<String ,dynamic> createResponse;
  CreateCategorySuccess(this.createResponse);

}
final class CreateCategoryFailure extends AllRequesterState {

  final String failureMessage;
  CreateCategoryFailure(this.failureMessage);

}

//Update category
final class UpdateCategoryLoading extends AllRequesterState{}
final class UpdateCategorySuccess extends AllRequesterState {
  final Map<String, dynamic> updateResponse;
  UpdateCategorySuccess(this.updateResponse);

}
final class UpdateCategoryFailure extends AllRequesterState {

  final Map<String, dynamic> failureMessage;
  UpdateCategoryFailure(this.failureMessage);

}


//get user list api


final class  GetUserListSuccess extends AllRequesterState {
  final Map<String ,dynamic> userResponse;
  GetUserListSuccess(this.userResponse);

}
final class GetUserListFailure extends AllRequesterState {

  final String failureMessage;
  GetUserListFailure(this.failureMessage);

}
//delete user list id

final class UserDeleteLoading extends AllRequesterState{}
final class  UserDeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> userDeleteList;
  UserDeleteSuccess(this.userDeleteList);

}


final class  UserDeleteFailure extends AllRequesterState{
  final Map<String, dynamic> deleteFailure;
  UserDeleteFailure(this.deleteFailure);

}

//Edits Details

final class UserEditDetailsLoading extends AllRequesterState{}
final class UserEditDetailsSuccess extends AllRequesterState{
  final Map<String, dynamic> userEditDeleteList;
  UserEditDetailsSuccess(this.userEditDeleteList);

}


final class  UserEditDetailsFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEditFailure;
  UserEditDetailsFailure(this.deleteEditFailure);

}
//user update

final class  UserUpdateLoading extends AllRequesterState {}

final class UserUpdateSuccess extends AllRequesterState {
  final Map<String ,dynamic> updateResponse;
  UserUpdateSuccess(this.updateResponse);

}
final class UserUpdateFailure extends AllRequesterState {

  final Map<String, dynamic> failureMessage;
  UserUpdateFailure(this.failureMessage);

}


//user create

final class  UserCreateLoading extends AllRequesterState{}
final class UserCreateSuccess extends AllRequesterState {
  final Map<String, dynamic> createResponse;
  UserCreateSuccess(this.createResponse);

}
final class UserCreateFailure extends AllRequesterState {

  final Map<String, dynamic> failureMessage;
  UserCreateFailure(this.failureMessage);

}





final class UserBillingLoading extends AllRequesterState{}
final class UserBillingSuccess extends AllRequesterState{
  final Map<String, dynamic> BillingList;
  UserBillingSuccess(this.BillingList);

}


final class  BillingFailure extends AllRequesterState{
  final Map<String, dynamic> billingFailure;
  BillingFailure(this.billingFailure);

}

///

final class UserBillingDeleteLoading extends AllRequesterState{}
final class UserBillingDeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteBillingList;
  UserBillingDeleteSuccess(this.deleteBillingList);

}


final class  UserBillingDeleteFailure extends AllRequesterState{
  final Map<String, dynamic> billingFailure;
  UserBillingDeleteFailure(this.billingFailure);

}

//create billing  address
final class  BillingCreateLoading extends AllRequesterState {}

final class   BillingCreateSuccess extends AllRequesterState {
  final Map<String ,dynamic> createResponse;
  BillingCreateSuccess(this.createResponse);

}
final class BillingCreateFailure extends AllRequesterState {

  final String failureMessage;
  BillingCreateFailure(this.failureMessage);

}
//update billing address

final class   BillingUpdateSuccess extends AllRequesterState {
  final Map<String ,dynamic> updateResponse;
  BillingUpdateSuccess(this.updateResponse);

}
final class  BillingUpdateFailure extends AllRequesterState {

  final String failureMessage;
  BillingUpdateFailure(this.failureMessage);

}
//product edit
final class ProductEditDetailsLoading extends AllRequesterState{}
final class ProductEditSuccess extends AllRequesterState{
  final Map<String, dynamic> userList;
  ProductEditSuccess(this.userList);

}


final class  ProductEditFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEditFailure;
  ProductEditFailure(this.deleteEditFailure);

}

//product list data
final class  ProductEditListLoading extends AllRequesterState{}
final class ProductEditListSuccess extends AllRequesterState{
  final Map<String, dynamic> userEditDeleteList;
  ProductEditListSuccess(this.userEditDeleteList);

}


final class  ProductEditListFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEditFailure;
  ProductEditListFailure(this.deleteEditFailure);

}
//create product

final class  CreateProductLoading extends AllRequesterState{}
final class CreateProductSuccess extends AllRequesterState{
  final Map<String, dynamic> createList;
  CreateProductSuccess(this.createList);

}


final class CreateProductFailure extends AllRequesterState{
  final Map<String, dynamic> createFailure;
  CreateProductFailure(this.createFailure);

}

//update product



final class  UpdateProductLoading extends AllRequesterState{}
final class  UpdateProductSuccess extends AllRequesterState{
  final Map<String, dynamic> updateList;
  UpdateProductSuccess(this.updateList);

}


final class UpdateProductFailure extends AllRequesterState{
  final Map<String, dynamic> updateFailure;
  UpdateProductFailure(this.updateFailure);

}

//assign the vendor

// reject Requisition

final class RejectLoading extends AllRequesterState{}
final class RejectSuccess extends AllRequesterState{
  final Map<String, dynamic> rejectList;
  RejectSuccess(this.rejectList);

}


final class RejectFailure extends AllRequesterState{
  final Map<String, dynamic> rejectFailure;
  RejectFailure(this.rejectFailure);

}


//Vendor Assign and billing Assign

final class VendorAssignLoading extends AllRequesterState{}
final class VendorAssignSuccess extends AllRequesterState{
  final Map<String, dynamic> vendorList;
  VendorAssignSuccess(this.vendorList);

}


final class VendorAssignFailure extends AllRequesterState{
  final Map<String, dynamic> vendorFailure;
  VendorAssignFailure(this.vendorFailure);

}



//status

final class StatusLoading extends AllRequesterState{}
final class StatusSuccess extends AllRequesterState{
  final Map<String, dynamic> statusList;
  StatusSuccess(this.statusList);

}


final class StatusFailure extends AllRequesterState{
  final Map<String, dynamic> statusFailure;
  StatusFailure(this.statusFailure);

}
//status changes
final class StatusChangeLoading extends AllRequesterState{}
final class StatusChangeSuccess extends AllRequesterState{
  final Map<String, dynamic> statusChangeList;
  StatusChangeSuccess(this.statusChangeList);

}


final class StatusChangeFailure extends AllRequesterState{
  final Map<String, dynamic> statusChangeFailure;
  StatusChangeFailure(this.statusChangeFailure);

}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//event list

final class EventListLoading extends AllRequesterState{}
final class EventListSuccess extends AllRequesterState{
  final Map<String, dynamic> eventList;
  EventListSuccess(this.eventList);

}


final class EventListFailure extends AllRequesterState{
  final Map<String, dynamic> eventFailure;
  EventListFailure(this.eventFailure);

}

//event delete state

final class EventDeleteLoading extends AllRequesterState{}
final class EventDeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteEventList;
  EventDeleteSuccess(this.deleteEventList);

}


final class  EventDeleteFailure extends AllRequesterState{
  final Map<String, dynamic>  deleteEventFailure;
  EventDeleteFailure(this. deleteEventFailure);

}

//event create state

final class EventCreateLoading extends AllRequesterState{}
final class  EventCreateSuccess extends AllRequesterState {
  final Map<String ,dynamic> createResponse;
  EventCreateSuccess(this.createResponse);

}
final class EventCreateFailure extends AllRequesterState {

  final Map<String, dynamic> failureMessage;
EventCreateFailure(this.failureMessage);

}

//Update events state
final class UpdateEventsLoading extends AllRequesterState{}
final class UpdateEventsSuccess extends AllRequesterState {
  final Map<String, dynamic> updateResponse;
  UpdateEventsSuccess(this.updateResponse);

}
final class UpdateEventsFailure extends AllRequesterState {

  final Map<String, dynamic> failureUpdateMessage;
  UpdateEventsFailure(this.failureUpdateMessage);

}
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//+++++++++++++++++++++++++++++++++++++++vendor list++++++++++++++++++++

final class VendorListLoading extends AllRequesterState{}
final class VendorListSuccess extends AllRequesterState{
  final Map<String, dynamic> eventList;
  VendorListSuccess(this.eventList);

}


final class VendorListFailure extends AllRequesterState{
  final Map<String, dynamic> eventFailure;
  VendorListFailure(this.eventFailure);

}

//vendor delete state

final class VendorDeleteLoading extends AllRequesterState{}
final class VendorDeleteSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteEventList;
  VendorDeleteSuccess(this.deleteEventList);

}


final class  VendorDeleteFailure extends AllRequesterState{
  final Map<String, dynamic>  deleteEventFailure;
  VendorDeleteFailure(this. deleteEventFailure);

}

//vendor create state

final class VendorCreateLoading extends AllRequesterState{}
final class  VendorCreateSuccess extends AllRequesterState {
  final Map<String ,dynamic> createResponse;
  VendorCreateSuccess(this.createResponse);

}
final class VendorCreateFailure extends AllRequesterState {

  final String failureMessage;
  VendorCreateFailure(this.failureMessage);

}

//Update vendor state
final class UpdateVendorLoading extends AllRequesterState{}
final class  UpdateVendorSuccess extends AllRequesterState {
  final Map<String, dynamic> updateResponse;
  UpdateVendorSuccess(this.updateResponse);

}
final class  UpdateVendorFailure extends AllRequesterState {

  final Map<String, dynamic> failureUpdateMessage;
  UpdateVendorFailure(this.failureUpdateMessage);

}
//Edit Details
final class VendorDetailsLoading extends AllRequesterState{}
final class VendorDetailsSuccess extends AllRequesterState{
  final Map<String, dynamic> vendorDetailsList;
  VendorDetailsSuccess(this.vendorDetailsList);

}


final class  VendorDetailsFailure extends AllRequesterState{
  final Map<String, dynamic> vendorEditFailure;
  VendorDetailsFailure(this.vendorEditFailure);

}

//View Details
final class VendorViewLoading extends AllRequesterState{}
final class VendorViewSuccess extends AllRequesterState{
  final Map<String, dynamic> vendorViewList;
  VendorViewSuccess(this.vendorViewList);

}


final class  VendorViewFailure extends AllRequesterState{
  final Map<String, dynamic> vendorEditFailure;
  VendorViewFailure(this.vendorEditFailure);

}


//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++