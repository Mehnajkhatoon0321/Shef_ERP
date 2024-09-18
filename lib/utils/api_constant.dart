import 'package:flutter/material.dart';

class  APIEndPoints{
  static const String baseUrl = 'https://erp.studyhallfoundation.org/api/';
  static const String login = '${baseUrl}login';
  static const String requesterList = '${baseUrl}req/';
  static const String requesterListAdd = '${baseUrl}req/create/';
  static const String getProduct = '${baseUrl}getproduct';
  static const String getSpecification = '${baseUrl}getspec';
  static const String postRequisition= '${baseUrl}req/store';

}