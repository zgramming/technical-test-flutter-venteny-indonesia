import 'dart:convert';

import '../../../config/constant.dart';
import '../../../core/helper/http_client.helper.dart';
import '../../../core/helper/share_preferences.helper.dart';
import '../../models/auth.model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login(String email, String password);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final HttpClientHelper client;
  AuthRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<AuthModel> login(String email, String password) async {
    final url = Uri.parse("$kBaseApiUrl/login");
    final response = await client.post(url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }));

    final status = response.statusCode;
    final body = response.body;
    final decodeBody = Map<String, dynamic>.from(json.decode(body));

    if (status != 200) {
      final hasErrorKey = decodeBody.containsKey('error');

      if (hasErrorKey) {
        final error = decodeBody['error'] as String;
        throw Exception(error);
      }

      throw Exception("Failed to login");
    }

    final result = AuthModel.fromMap(decodeBody).copyWith(email: email);

    return result;
  }

  @override
  Future<void> logout() async {
    // Remove all shared preferences
    await SharedPreferencesHelper.clear();
  }
}
