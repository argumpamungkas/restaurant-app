import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';
import 'package:restaurant_app/data/models/search_restaurant/search_restaurant.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final TextEditingController _queryController = TextEditingController();

  late List<DataItemListRestaurant> _listRestaurant;
  ResultStatus _status = ResultStatus.initial;
  late String _message;

  List<DataItemListRestaurant> get listRestaurant => _listRestaurant;
  ResultStatus get status => _status;
  String get message => _message;
  TextEditingController get queryController => _queryController;

  setQuery(String value) {
    if (value.isEmpty || queryController.text.isEmpty) {
      reset();
      notifyListeners();
      return;
    }

    searchRestaurant(value);
    notifyListeners();
  }

  void reset() {
    _status = ResultStatus.initial;
    _listRestaurant.clear();
  }

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _status = ResultStatus.loading;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      ResponseSearchRestaurant responseSearchRestaurant =
          await _apiService.searchRestaurant(query);
      if (responseSearchRestaurant.error == false) {
        _listRestaurant = responseSearchRestaurant.restaurants;
        if (responseSearchRestaurant.founded == 0 || _listRestaurant.isEmpty) {
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
        _message = "Failed to Search Restaurant, Check your Connection";
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
      _message = "Failed to Search Restaurant, Check your connection.";
      notifyListeners();
      return _message;
    }
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }
}
