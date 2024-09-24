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
