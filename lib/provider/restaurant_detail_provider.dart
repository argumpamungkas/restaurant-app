import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/detail_restaurant/data_detail_restaurant.dart';
import 'package:restaurant_app/data/models/detail_restaurant/restaurant_detail.dart';
import 'package:restaurant_app/data/models/review/response_review.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late DataDetailRestaurant _restaurantData;
  ResultStatus _status = ResultStatus.initial;
  late String _message;

  RestaurantDetailProvider(String id) {
    fetchDetailRestaurant(id);
  }

  DataDetailRestaurant get restaurantData => _restaurantData;
  ResultStatus get status => _status;
  String get message => _message;
  TextEditingController get nameController => _nameController;
  TextEditingController get reviewController => _reviewController;
  GlobalKey<FormState> get formKey => _formKey;

  setName(String value) {
    _nameController.text = value;
    notifyListeners();
  }

  setReview(String value) {
    _reviewController.text = value;
    notifyListeners();
  }

  Future<dynamic> fetchDetailRestaurant(String id) async {
    try {
      _status = ResultStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      ResponseDetailRestaurant responseDetailRestaurant =
          await _apiService.fetchRestaurantDetail(id);
      if (responseDetailRestaurant.error == false) {
        _status = ResultStatus.hasData;
        _restaurantData = responseDetailRestaurant.data;
        notifyListeners();
        return _restaurantData;
      } else {
        _status = ResultStatus.error;
        _message = responseDetailRestaurant.message;
        notifyListeners();
        return _message;
      }
    } on SocketException {
      _status = ResultStatus.error;
      _message = "Your is Offline. Check your Connection";
      notifyListeners();
      return _message;
    } catch (e) {
      _status = ResultStatus.error;
      _message = "Failed to Load Data, Check your connection.";
      notifyListeners();
      return _message;
    }
  }

  Future<dynamic> updateDetailRestaurant(String id) async {
    try {
      ResponseDetailRestaurant responseDetailRestaurant =
          await _apiService.fetchRestaurantDetail(id);
      if (responseDetailRestaurant.error == false) {
        _status = ResultStatus.hasData;
        _restaurantData = responseDetailRestaurant.data;
        notifyListeners();
        return _restaurantData;
      } else {
        _status = ResultStatus.error;
        _message = responseDetailRestaurant.message;
        notifyListeners();
        return _message;
      }
    } on SocketException {
      _status = ResultStatus.error;
      _message = "Your is Offline. Check your Connection";
      notifyListeners();
      return _message;
    } catch (e) {
      _status = ResultStatus.error;
      _message = "Failed to Load Data, Check your connection.";
      notifyListeners();
      return _message;
    }
  }

  Future<ResultStatus> addReview(String id) async {
    try {
      ResponseReview responseReview = await _apiService.addReview(
          id, nameController.text, reviewController.text);
      if (responseReview.error == false) {
        _status = ResultStatus.hasData;
        notifyListeners();
        await updateDetailRestaurant(id);
        reset();
        return _status;
      } else {
        _status = ResultStatus.error;
        _message = responseReview.message;
        notifyListeners();
        return _status;
      }
    } on SocketException {
      _status = ResultStatus.error;
      _message = "Your is Offline. Check your Connection";
      notifyListeners();
      return _status;
    } catch (e) {
      _status = ResultStatus.error;
      _message = "Failed to Load Data, Check your connection.";
      notifyListeners();
      return _status;
    }
  }

  void reset() {
    nameController.text = "";
    reviewController.text = "";
  }

  @override
  void dispose() {
    _nameController.dispose();
    _reviewController.dispose();
    super.dispose();
  }
}
