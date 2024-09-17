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