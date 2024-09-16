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

final class ViewCartSuccess extends AllRequesterState{
  final Map<String, dynamic> viewCartDetails;
  ViewCartSuccess(this.viewCartDetails);

}
