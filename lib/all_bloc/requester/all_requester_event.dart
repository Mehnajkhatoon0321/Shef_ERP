part of 'all_requester_bloc.dart';


sealed class AllRequesterEvent {}
class AddCartDetailHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  AddCartDetailHandler(this.search,this.page,this.size);
}
class RequesterHandler extends AllRequesterEvent {

  RequesterHandler();
}
class ProductListHandler extends AllRequesterEvent {
  String categoryID;


  ProductListHandler(this.categoryID,);
}

class SepListHandler extends AllRequesterEvent {
  String productID;


  SepListHandler(this.productID);
}
class DeleteHandlers extends AllRequesterEvent {
  int ID;


  DeleteHandlers(this.ID);
}

class AddRequisitionHandler extends AllRequesterEvent {
  final String date;
  final String unit;
  final String nextDate;
  final String time;
  final String userId; // Keep this as a string for now
  final List<Map<String, dynamic>> requisitionList;

  AddRequisitionHandler({
    required this.date,
    required this.unit,
    required this.nextDate,
    required this.time,
    required this.userId,
    required this.requisitionList,
  });
}

//Edit

class EditDetailHandler extends AllRequesterEvent {
  String id;
  EditDetailHandler(this.id);
}
//update profile

class UpdateRequisitionEventHandler extends AllRequesterEvent {
  final String date;
  final String unit;
  final String time;
  final String product;
  final String specification;
  final String userid;
  final String quantity;
  final String additional;
  final String event;
  final String delivery_date;
  final String preImg;
  final String reqID;

  final File? Image;

  UpdateRequisitionEventHandler({
    required this.date ,
    required this.unit ,
    required this.time ,
    required this.product ,
    required this.specification ,
    required this.userid ,
    required this.quantity ,
    required this.additional ,
    required this.event ,
    required this.delivery_date ,
    required this.preImg ,
    required this.reqID ,
    required this.Image ,





  });
}
//Reject Event
class RejectHandler extends AllRequesterEvent {
  String remark;
  RejectHandler(this.remark);
}

//Master Events

class MasterDetailHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  MasterDetailHandler(this.search,this.page,this.size);
}

class DeleteMasterHandlers extends AllRequesterEvent {
  int id;


  DeleteMasterHandlers(this.id);
}
class EditMasterHandler extends AllRequesterEvent {
  String id;
  EditMasterHandler(this.id);
}

// Master Product  Services

class MasterServiceHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  MasterServiceHandler(this.search,this.page,this.size);
}

class DeleteMasterServiceHandlers extends AllRequesterEvent {
  int id;


  DeleteMasterServiceHandlers(this.id);
}

class EditMasterServiceHandler extends AllRequesterEvent {
  String id;
  EditMasterServiceHandler(this.id);
}


//Master Category  Services
class MasterCategoryHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  MasterCategoryHandler(this.search,this.page,this.size);
}

class DeleteMasterCategoryHandlers extends AllRequesterEvent {
  int id;


  DeleteMasterCategoryHandlers(this.id);
}

class EditMasterCategoryHandler extends AllRequesterEvent {
  String id;
  EditMasterCategoryHandler(this.id);
}
//Get Unit

class GetUnitHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  GetUnitHandler(this.search,this.page,this.size);
}

//Destroy

class DeleteUnitHandlers extends AllRequesterEvent {
  int id;


  DeleteUnitHandlers(this.id);
}

//create unit

class UnitCreateEventHandler extends AllRequesterEvent {
  final String billingAddress;
  final String address;
  final String name;
  UnitCreateEventHandler({required this.billingAddress, required this.address, required this.name});
}
