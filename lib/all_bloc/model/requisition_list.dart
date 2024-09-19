class Requisition {
  final String date;
  final String unit;
  final String time;
  final int userId;
  final String deliveryDate;
  final List<RequisitionItem> requisitionList;

  Requisition({
    required this.date,
    required this.unit,
    required this.time,
    required this.userId,
    required this.deliveryDate,
    required this.requisitionList,
  });
}

class RequisitionItem {
  final String product;
  final String specialisation;
  final String remark;
  final String quantity;
  final String image; // This can remain if you want to keep track of the image

  RequisitionItem({
    required this.product,
    required this.specialisation,
    required this.remark,
    required this.quantity,
    required this.image,
  });
}
