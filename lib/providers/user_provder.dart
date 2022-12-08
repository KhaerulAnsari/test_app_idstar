import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tes_app_idstar/models/user_model.dart';
import 'package:tes_app_idstar/ui/widgets/snackbar_box.dart';

class UserProvider extends ChangeNotifier {
  Future<List<UserModel>> getListUser() async {
    try {
      var response = await Dio().get(
        'https://gorest.co.in/public/v2/users',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 6f4ae0d31f70f7b130dc341d7887f55870dc5a04a1adfdcfacc6af2c33e50b98',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<UserModel> data = [];

        List parsedJson = response.data;

        parsedJson.forEach(
          (e) {
            data.add(UserModel.fromJson(e));
          },
        );
        return data;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<UserModel?> createUser(Map<String, dynamic> data) async {
    try {
      var response = await Dio().post(
        'https://gorest.co.in/public/v2/users',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 6f4ae0d31f70f7b130dc341d7887f55870dc5a04a1adfdcfacc6af2c33e50b98',
          },
        ),
        data: data,
      );
      if (response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      }
    } catch (e) {
      snackbarBox(
        e.toString(),
      );
    }
  }

  Future<UserModel?> updateUser(int id, Map<String, dynamic> data) async {
    try {
      var response = await Dio().patch(
        'https://gorest.co.in/public/v2/users/$id',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 6f4ae0d31f70f7b130dc341d7887f55870dc5a04a1adfdcfacc6af2c33e50b98',
          },
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(
          response.data,
        );
      }
    } on DioError catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      var response = await Dio().delete(
        'https://gorest.co.in/public/v2/users/$id',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer 6f4ae0d31f70f7b130dc341d7887f55870dc5a04a1adfdcfacc6af2c33e50b98',
          },
        ),
      );
    } on DioError catch (e) {
      return snackbarBox(
        e.message.toLowerCase(),
      );
    }
  }
}
