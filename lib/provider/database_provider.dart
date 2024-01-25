import 'package:flutter/material.dart';
import 'package:restaurant_app/common/result_status.dart';
import 'package:restaurant_app/data/helpers/db_helper.dart';
import 'package:restaurant_app/data/models/list_restaurant/data_item_list_restaurant.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  List<DataItemListRestaurant> _listFavorite = [];
  late ResultStatus _status;
  late String _message;

  List<DataItemListRestaurant> get listFavorite => _listFavorite;
  ResultStatus get resultStatus => _status;
  String get message => _message;

  void _getFavorite() async {
    _listFavorite = await databaseHelper.getFavorite();
    if (_listFavorite.isNotEmpty) {
      _status = ResultStatus.hasData;
    } else {
      _status = ResultStatus.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(DataItemListRestaurant dataRestaurant) async {
    try {
      await databaseHelper.insertFavorite(dataRestaurant);
      _getFavorite();
    } catch (e) {
      _status = ResultStatus.error;
      _message = 'Something Wrond, restart your app';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _status = ResultStatus.error;
      _message = 'Something wrong, restart your apps';
      notifyListeners();
    }
  }
}
