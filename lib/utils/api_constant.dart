

class  APIEndPoints{

  //demoUrl
  static const String baseUrl = 'https://demo.studyhallfoundation.org/api/';
   // static const String baseUrl = 'https://erp.studyhallfoundation.org/api/';
  static const String login = '${baseUrl}login';
  static const String requesterList = '${baseUrl}req/';
  static const String requesterListAdd = '${baseUrl}req/create/';
  static const String getProduct = '${baseUrl}getproduct';
  static const String getSpecification = '${baseUrl}getspec';
  static const String postRequisition= '${baseUrl}req/store';
  static const String postDelete= '${baseUrl}req/destroy/';
  static const String postReqEdit= '${baseUrl}req/edit/';
  static const String postReqUpdate= '${baseUrl}req/update/';
  static const String postMark= '${baseUrl}req/status';


  //Friday  unit and category
  static const String getUnits= '${baseUrl}unit';
  static const String deleteUnits= '${baseUrl}unit/delete/';
  static const String createUnits= '${baseUrl}unit/create';
  static const String updateUnits= '${baseUrl}unit/update';

  //product
  static const String productGetCategory= '${baseUrl}category/';
  static const String productGetCategoryDelete= '${baseUrl}category/delete/';
  static const String productGetCategoryCreate= '${baseUrl}category/create';
  static const String productCategoryUpdate= '${baseUrl}category/update';

  //UserList Saturday
  static const String getUserList= '${baseUrl}user/';
  static const String deleteUserList= '${baseUrl}user/delete/';
  static const String editDetailsUserList= '${baseUrl}user/edit/';
  static const String createDetailsUserList= '${baseUrl}user/create';
  static const String updateDetailsUserList= '${baseUrl}user/update';

  //billing address
  static const String billingEditDetailsUserList= '${baseUrl}billing/edit/';
  static const String getBillingList= '${baseUrl}billing/';
  static const String deleteBillingList= '${baseUrl}billing/delete/';
  static const String createBillingList= '${baseUrl}billing/create';
  static const String updateBillingList= '${baseUrl}billing/update';

  //product

  static const String getProductList= '${baseUrl}product/';
  static const String deleteProductList= '${baseUrl}product/delete/';
  static const String createProductList= '${baseUrl}product/create';
  static const String updateProductList= '${baseUrl}product/update';
  static const String EditList= '${baseUrl}product/edit/';
  static const String getEditList= '${baseUrl}product/create';
  static const String getStatusProductList= '${baseUrl}product/status';
  static const String getStatusChangeProductList= '${baseUrl}product/statusChange';

//vendor reject
  static const String actionVendor= '${baseUrl}req/action';
  static const String actionRejectVendor= '${baseUrl}req/rejectpm';
  static const String actionRejectUnit= '${baseUrl}req/rejectunit';


  //events

  static const String getEventsList= '${baseUrl}event/';
  static const String deleteEventList= '${baseUrl}event/delete/';
  static const String createEventList= '${baseUrl}event/create';
  static const String updateEventList= '${baseUrl}event/update';
  static const String   editEventList= '${baseUrl}event/edit';



  //vendor data



  static const String getVendorList= '${baseUrl}vendor/';
  static const String deleteVendorList= '${baseUrl}vendor/delete/';
  static const String createVendorList= '${baseUrl}vendor/create';
  static const String updateVendorList= '${baseUrl}vendor/update';
  static const String   editVendorList= '${baseUrl}vendor/edit';

  static const String   viewPost= '${baseUrl}vendor/view/';




}