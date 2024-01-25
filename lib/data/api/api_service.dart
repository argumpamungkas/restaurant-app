import 'dart:io';

import 'package:dio/dio.dart';
import 'package:restaurant_app/data/api/api_link.dart';
import 'package:restaurant_app/data/models/detail_restaurant/restaurant_detail.dart';
import 'package:restaurant_app/data/models/list_restaurant/restaurant_list.dart';
import 'package:restaurant_app/data/models/review/response_review.dart';
import 'package:restaurant_app/data/models/search_restaurant/search_restaurant.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<ResponseListRestaurant> fetchRestaurantList() async {
    try {
      Response response = await _dio.get("$baseUrl/list");
      if (response.statusCode == 200) {
        return ResponseListRestaurant.fromJson(response.data);
      } else {
        throw Exception("Failed to load list data Restaurant");
      }
    } on SocketException {
      throw "Your is Offline. Check your connection";
    } on FormatException {
      throw "Bad response format";
    } catch (_) {
      rethrow;
    }
  }

  Future<ResponseDetailRestaurant> fetchRestaurantDetail(String id) async {
    try {
      Response response = await _dio.get("$baseUrl/detail/$id");
      if (response.statusCode == 200) {
        return ResponseDetailRestaurant.fromJson(response.data);
      } else {
        throw Exception("Failed to load list data Restaurant Detail");
      }
    } on SocketException {
      throw "Your is Offline. Check your connection";
    } on FormatException {
      throw "Bad response format";
    } catch (_) {
      rethrow;
    }
  }

  Future<ResponseReview> addReview(
      String id, String name, String review) async {
    try {
      Response response = await _dio.post(
        "$baseUrl/review",
        data: {
          "id": id,
          "name": name,
          "review": review,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 201) {
        return ResponseReview.fromJson(response.data);
      } else {
        throw Exception("Failed to post review");
      }
    } on SocketException {
      throw "Your is Offline. Check your connection";
    } on FormatException {
      throw "Bad response format";
    } catch (_) {
      rethrow;
    }
  }

  Future<ResponseSearchRestaurant> searchRestaurant(String query) async {
    try {
      Response response = await _dio.get("$baseUrl/search?q=$query");
      if (response.statusCode == 200) {
        return ResponseSearchRestaurant.fromJson(response.data);
      } else {
        throw Exception("Failed to post review");
      }
    } on SocketException {
      throw "Your is Offline. Check your connection";
    } on FormatException {
      throw "Bad response format";
    } catch (_) {
      rethrow;
    }
  }
}
