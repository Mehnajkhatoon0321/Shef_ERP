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
