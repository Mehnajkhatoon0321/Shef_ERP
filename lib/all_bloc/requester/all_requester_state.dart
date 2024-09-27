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
  final Map<String, dynamic> deleteEventServiceList;
  DeleteServiceSuccess(this.deleteEventServiceList);

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








//Events  From Event list

final class EventLoading extends AllRequesterState{}
final class EventSuccess extends AllRequesterState{
  final Map<String, dynamic> eventList;
  EventSuccess(this.eventList);

}


final class  EventFailure extends AllRequesterState{
  final Map<String, dynamic> eventFailure;
  EventFailure(this.eventFailure);

}
//Delete Event From List
final class DeleteEventLoading extends AllRequesterState{}
final class DeleteEventSuccess extends AllRequesterState{
  final Map<String, dynamic> deleteEventList;
  DeleteEventSuccess(this.deleteEventList);

}


//  Edit Event
final class EditEventLoading extends AllRequesterState{}
final class EditEventSuccess extends AllRequesterState{
  final Map<String, dynamic> editEventList;
  EditEventSuccess(this.editEventList);

}


final class EditSuccessEventFailure extends AllRequesterState{
  final Map<String, dynamic> deleteEventFailure;
  EditSuccessEventFailure(this.deleteEventFailure);

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