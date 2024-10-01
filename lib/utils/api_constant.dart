

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

  //Friday
  static const String getUnits= '${baseUrl}unit';
  static const String deleteUnits= '${baseUrl}unit/delete/';
  static const String createUnits= '${baseUrl}unit/create';
  static const String updateUnits= '${baseUrl}unit/update';
  static const String productGetCategory= '${baseUrl}category/';
  static const String productGetCategoryDelete= '${baseUrl}category/delete/';
  static const String productGetCategoryCreate= '${baseUrl}category/create';
  static const String productCategoryUpdate= '${baseUrl}category/update';

  //UserList Saturday
  static const String getUserList= '${baseUrl}user/';
  static const String deleteUserList= '${baseUrl}user/delete/';
  static const String editDetailsUserList= '${baseUrl}user/edit/';

  //billing address

  static const String getBillingList= '${baseUrl}billing/';
  static const String deleteBillingList= '${baseUrl}billing/delete/';
}