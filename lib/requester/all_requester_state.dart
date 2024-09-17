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
//


}
final class SpecificationListLoading extends AllRequesterState{}
final class SpecificationListSuccess extends AllRequesterState{
  final Map<String, dynamic> specList;
  SpecificationListSuccess(this.specList);
//


}