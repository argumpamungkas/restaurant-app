import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/data/models/list_restaurant/restaurant_list.dart';

class RestauranProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  RestauranProvider() {
    fetchRestaurantList();
  }

  late List<DataItemListRestaurant> _listRestaurant;
  late ResultStatus _status;
  late String _message;

  List<DataItemListRestaurant> get listRestaurant => _listRestaurant;
  ResultStatus get status => _status;
  String get message => _message;

  Future<dynamic> fetchRestaurantList() async {
    try {
      _status = ResultStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      ResponseListRestaurant restaurant =
          await _apiService.fetchRestaurantList();
      if (restaurant.error == false) {
        _listRestaurant = restaurant.restaurants;
        if (_listRestaurant.isEmpty) {
          _status = ResultStatus.noData;
          _message = "Data Restaurant is Empty";
          notifyListeners();
          return _message;
        } else {
          _status = ResultStatus.hasData;
          notifyListeners();
          return _listRestaurant;
        }
      } else {
        _status = ResultStatus.error;
        _message = restaurant.message;
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
}
