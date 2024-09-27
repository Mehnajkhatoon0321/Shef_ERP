

class  APIEndPoints{
  static const String baseUrl = 'https://erp.studyhallfoundation.org/api/';
  static const String login = '${baseUrl}login';
  static const String requesterList = '${baseUrl}req/';
  static const String requesterListAdd = '${baseUrl}req/create/';
  static const String getProduct = '${baseUrl}getproduct';
  static const String getSpecification = '${baseUrl}getspec';
  static const String postRequisition= '${baseUrl}req/store';
  static const String postDelete= '${baseUrl}req/destroy/';
  static const String postReqEdit= '${baseUrl}req/edit/';
  static const String postReqUpdate= '${baseUrl}req/update/';
  static const String getUnits= '${baseUrl}unit';
  static const String deleteUnits= '${baseUrl}unit/delete/';
  static const String createUnits= '${baseUrl}billing/create';

}