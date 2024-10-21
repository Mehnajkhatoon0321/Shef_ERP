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
class UnitUpdateEventHandler extends AllRequesterEvent {
  final String billingAddress;
  final String address;
  final String name;
  final String id;
  UnitUpdateEventHandler({required this.billingAddress, required this.address, required this.name, required this.id});
}
//product get category
class GetProductCategoryHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  GetProductCategoryHandler(this.search,this.page,this.size);
}

//create category

class CategoryCreateEventHandler extends AllRequesterEvent {
  final String category;

  CategoryCreateEventHandler({required this.category});
}
//Get UserList
class CategoryUpdateEventHandler extends AllRequesterEvent {
  final String category;
  int userId;
   int id;
  CategoryUpdateEventHandler({required this.category,required this.userId,required this.id,});
}

class GetUserListHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  GetUserListHandler(this.search,this.page,this.size);
}

//delete User Id

class DeleteUserIDHandlers extends AllRequesterEvent {
  int id;


  DeleteUserIDHandlers(this.id);
}

//user update

class UserUpdateEventHandler extends AllRequesterEvent {

  final String name;
  final String email;
  final String contact;
  final String address;
  final String role;
  final String unitID;
  final String id;
  final String password;
  final String designation;
 UserUpdateEventHandler({ required this.name, required this.email, required this.contact,required this.address,required this.role, required this.unitID, required this.id, required this.password, required this.designation});
}


//user create

class UserCreateEventHandler extends AllRequesterEvent {

  final String name;
  final String email;
  final String contact;
  final String address;
  final String role;
  final String unitID;
  final String id;
  final String password;
  final String designation;
  UserCreateEventHandler({ required this.name, required this.email, required this.contact,required this.address,required this.role, required this.unitID, required this.id, required this.password, required this.designation});
}
//Edit Details
class EditDetailUserHandler extends AllRequesterEvent {
  String id;
  EditDetailUserHandler(this.id);
}
class GetBillingListHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  GetBillingListHandler(this.search,this.page,this.size);
}
//delete billing id

class DeleteBillingHandlers extends AllRequesterEvent {
  int id;


  DeleteBillingHandlers(this.id);
}

class BillingCreateEventHandler extends AllRequesterEvent {
  final String billingAddress;
  final String address;

  BillingCreateEventHandler({required this.billingAddress, required this.address});
}
class BillingUpdateEventHandler extends AllRequesterEvent {
  final String billingAddress;
  final String address;

  final String id;
  BillingUpdateEventHandler({required this.billingAddress, required this.address, required this.id});
}
//product edit

class ProductEditDetailUserHandler extends AllRequesterEvent {
  String id;
  ProductEditDetailUserHandler(this.id);
}
//get create list

class ProductListUserHandler extends AllRequesterEvent {
  String id;
  ProductListUserHandler(this.id);
}

//post create api


class ProductCreateEventHandler extends AllRequesterEvent {
  final String cateName;
  final String name;
  final String specification;
  final String user_id;

  ProductCreateEventHandler({required this.cateName, required this.name, required this.specification, required this.user_id,});
}


class ProductUpdateEventHandler extends AllRequesterEvent {
  final String cateName;
  final String name;
  final String specification;
  final String user_id;
  final String id;

  ProductUpdateEventHandler({required this.cateName,required this.id, required this.name, required this.specification, required this.user_id,});
}

//product status

class ProductStatusHandler extends AllRequesterEvent {
  String id;
  ProductStatusHandler({required  this.id});
}



class ProductStatusChangeHandler extends AllRequesterEvent {
  String id;
  String status;
  String userID;
  ProductStatusChangeHandler({required this.userID, required this.status,required this.id});
}



class VendorActionHandler extends AllRequesterEvent {
  String userRole;
  String btnAssign;
  String userID;
  String vendor;
  String billing;
  String count;
  List<dynamic> allCount;
  VendorActionHandler({required this.userID, required this.btnAssign,required this.userRole,required this.vendor,required this.billing,required this.allCount,required this.count});
}
//Reject

class VendorRejectHandler extends AllRequesterEvent {

  String user_id;
  String btnReject;
  String pmremark;


  List<dynamic> pmCount;
  VendorRejectHandler({required this.user_id, required this.btnReject,required this.pmremark,required this.pmCount});
}

//unitApproved
class UnitActionHandler extends AllRequesterEvent {
  String userRole;
  String btnAssign;
  String userID;

  List<dynamic> count;
  UnitActionHandler({required this.userID, required this.btnAssign,required this.userRole,required this.count});
}
//Events list

class EventListHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  EventListHandler(this.search,this.page,this.size);
}
//event delete

class DeleteEventHandlers extends AllRequesterEvent {
  int id;


  DeleteEventHandlers(this.id);
}

//event create

class CreateEventHandler extends AllRequesterEvent {
  final String category;

  CreateEventHandler({required this.category});
}

class UpdateEventHandler extends AllRequesterEvent {
  final String name;

  int id;
  UpdateEventHandler({required this.name,required this.id,});
}
//
//vendor in master

class VendorListHandler extends AllRequesterEvent {
  String search;
  int page;
  int size;
  VendorListHandler(this.search,this.page,this.size);
}
class DeleteVendorHandlers extends AllRequesterEvent {
  int id;


  DeleteVendorHandlers(this.id);
}

class VendorUserHandler extends AllRequesterEvent {
  String id;
  VendorUserHandler(this.id);
}

class VendorViewHandler extends AllRequesterEvent {
  String id;
  VendorViewHandler(this.id);
}
//vendor update

class VendorUpdateHandler extends AllRequesterEvent {
  final String name;
  final String contact;
  final String address;
  final String whatsapp;
  final String companyType;
  final String email;
  final String password;
  final String companyName;
  final String caddress;
  final String pan;
  final String gst;
  final String tan;
  final String companyEmail;
  final String accountName;
  final String accountNo;
  final String ifsc;
  final String bankName;
  final String branch; // Now required
  final String vendorId;
  final File? panImage;
  final File? gstImage;
  final File? cancelledImage;

  VendorUpdateHandler({
    required this.name,
    required this.contact,
    required this.address,
    required this.whatsapp,
    required this.companyType,
    required this.companyName,
    required this.caddress,
    required this.pan,
    required this.gst,
    required this.email,
    required this.password,
    required this.tan,
    required this.companyEmail,
    required this.accountName,
    required this.accountNo,
    required this.ifsc,
    required this.bankName,
    required this.branch, // Added here
    required this.vendorId,
    required this.panImage,
    required this.gstImage,
    required this.cancelledImage,
  });
}
//vendor create

class VendorCreateHandler extends AllRequesterEvent {
  final String name;
  final String contact;
  final String address;
  final String email;
  final String password;
  final String whatsapp;
  final String companyType;
  final String companyName;
  final String caddress;
  final String pan;
  final String gst;
  final String tan;

  final String accountName;
  final String accountNo;
  final String ifsc;
  final String bankName;
  final String branch; // Now required
  final String roles;
  final File? panImage;
  final File? gstImage;
  final File? cancelledImage;

  VendorCreateHandler({
    required this.name,
    required this.email,
    required this.password,
    required this.contact,
    required this.address,
    required this.whatsapp,
    required this.companyType,
    required this.companyName,
    required this.caddress,
    required this.pan,
    required this.gst,
    required this.tan,

    required this.accountName,
    required this.accountNo,
    required this.ifsc,
    required this.bankName,
    required this.branch, // Added here
    required this.roles,
    required this.panImage,
    required this.gstImage,
    required this.cancelledImage,
  });
}
//mark as a delivery

class MarkRequisitionEventHandler extends AllRequesterEvent {
  final String remark;

  final String userid;

  final String reqID;
  final String status;

  final File? Image;

  MarkRequisitionEventHandler({
    required this.status ,
    required this.remark ,

    required this.userid ,

    required this.reqID ,
    required this.Image ,





  });
}

//unitHead Reject

class UnitRejectHandler extends AllRequesterEvent {

  String user_id;
  String btnReject;
  String pmremark;


  List<dynamic> unitCount;
  UnitRejectHandler({required this.user_id, required this.btnReject,required this.pmremark,required this.unitCount});
}