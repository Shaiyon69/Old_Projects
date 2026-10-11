import 'dart:convert';
// import '../variables.dart';
// import 'package:http/http.dart' as http;
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_service.dart';

class ApiService {
  static Future<String> _getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  static Future<List<Audit>> getAudit() async {
    String token = await _getToken();
    final response = await HttpHelper.get('/auditlogs', token: token);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<dynamic> auditList;
      if (responseData is List) {
        auditList = responseData;
      } else if (responseData is Map<String, dynamic>) {
        auditList =
            responseData['data'] ??
            responseData['audits'] ??
            responseData['audit_logs'] ??
            [];
        if (auditList.isEmpty && responseData.containsKey('data')) {
          auditList = responseData['data'];
        }
      } else {
        throw Exception('Invalid data format');
      }
      return auditList
          .map((e) => Audit.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } else {
      throw Exception('Failed to load Audit: ${response.statusCode}');
    }
  }
}
