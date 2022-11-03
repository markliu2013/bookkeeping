import 'dart:convert';
import 'package:dio/dio.dart';

import '/commons/commons.dart';
import '/add_flow/add_flow.dart';
import '/flows/flows.dart';

class FlowRepository {

  Future<bool> saveExpense(DealAddRequest request) async {
    String response = await HttpClient().post('expenses', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> refundExpense(int id, DealAddRequest request) async {
    String response = await HttpClient().post('expenses/$id/refund', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> updateExpense(int id, DealAddRequest request) async {
    String response = await HttpClient().put('expenses/$id', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> saveIncome(DealAddRequest request) async {
    String response = await HttpClient().post('incomes', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> refundIncome(int id, DealAddRequest request) async {
    String response = await HttpClient().post('incomes/$id/refund', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> updateIncome(int id, DealAddRequest request) async {
    String response = await HttpClient().put('incomes/$id', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> saveTransfer(TransferAddRequest request) async {
    String response = await HttpClient().post('transfers', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<bool> updateTransfer(int id, TransferAddRequest request) async {
    String response = await HttpClient().put('transfers/$id', data: request.toJson());
    return json.decode(response)['success'];
  }

  Future<List<FlowModel>> query(FlowQueryRequest request) async {
    String response = await HttpClient().get('flows', params: request.toJson());
    var responseDecoded = json.decode(response);
    return (responseDecoded['data']['result']['content']).map<FlowModel>((i) => FlowModel.fromJson(i)).toList();
  }

  Future<FlowModel> get(int id) async {
    String response = await HttpClient().get('flows/$id');
    return FlowModel.fromJson(json.decode(response)['data']);
  }

  Future<bool> confirm(int id) async {
    String response = await HttpClient().put('flows/$id/confirm');
    return json.decode(response)['success'];
  }

  Future<bool> delete(String id) async {
    String response = await HttpClient().delete('flows/$id');
    return json.decode(response)['success'];
  }

  Future<List<FlowImage>> getImages(int id) async {
    String response = await HttpClient().get('flows/$id/images');
    return json.decode(response)['data'].map<FlowImage>((i) => FlowImage.fromJson(i)).toList();
  }

  Future<bool> deleteImage(String id) async {
    String response = await HttpClient().delete('flow-images/$id');
    return json.decode(response)['success'];
  }

  Future<String> getUploadToken() async {
    String response = await HttpClient().get('flow-images/upload-token');
    return json.decode(response)['data'];
  }

  Future<bool> uploadImage(String filePath, String userId, String flowId) async {
    String token = await getUploadToken();
    MultipartFile file = await MultipartFile.fromFile(filePath);
    String response = await HttpClient().upload({
      'file': file,
      'token': token,
      'x:userId': userId
    });
    await HttpClient().post('flows/$flowId/image', data: json.decode(response)['data']['id']);
    return true;
  }

}