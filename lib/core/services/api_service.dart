import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  static String get baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000/api';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return 'http://10.0.2.2:8000/api';
    } else {
      return 'http://localhost:8000/api';
    }
  }

  // Get Farmers
  static Future<List<dynamic>> getFarmers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/farmers/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error getting farmers: $e');
    }
    return [];
  }

  // Create Farmer
  static Future<Map<String, dynamic>?> createFarmer(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/farmers/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error creating farmer: $e');
    }
    return null;
  }

  // Get Buyers
  static Future<List<dynamic>> getBuyers() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/buyers/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error getting buyers: $e');
    }
    return [];
  }

  // Get Deliveries
  static Future<List<dynamic>> getDeliveries() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/deliveries/'));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error getting deliveries: $e');
    }
    return [];
  }

  // Create Delivery
  static Future<Map<String, dynamic>?> createDelivery(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/deliveries/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      if (response.statusCode == 201) {
        return json.decode(response.body);
      }
    } catch (e) {
      debugPrint('Error creating delivery: $e');
    }
    return null;
  }
}
