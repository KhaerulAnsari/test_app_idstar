import 'package:flutter/material.dart';
import 'package:tes_app_idstar/models/user_model.dart';
import 'package:tes_app_idstar/theme.dart';

class DetailUserPage extends StatelessWidget {
  UserModel? userData;

  DetailUserPage({super.key, this.userData});

  @override
  Widget build(BuildContext context) {
    textId() {
      return Text(
        userData!.id!.toString(),
        style: blackTextStyle.copyWith(
          fontSize: 22,
          fontWeight: medium,
        ),
      );
    }

    textName() {
      return Text(
        userData!.name!,
        style: blackTextStyle.copyWith(
          fontSize: 22,
          fontWeight: medium,
        ),
      );
    }

    textEmail() {
      return Text(
        userData!.email!,
        style: greyTextStyle.copyWith(
          fontSize: 16,
          fontWeight: light,
        ),
      );
    }

    textGender() {
      return Text(
        userData!.gender!,
        style: greyTextStyle.copyWith(
          fontSize: 16,
          fontWeight: light,
        ),
      );
    }

    textStatus() {
      return Text(
        userData!.status!,
        style: greyTextStyle.copyWith(
          fontSize: 16,
          fontWeight: light,
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textId(),
              const SizedBox(
                height: 5,
              ),
              textName(),
              const SizedBox(
                height: 5,
              ),
              textEmail(),
              const SizedBox(
                height: 5,
              ),
              textGender(),
              const SizedBox(
                height: 5,
              ),
              textStatus(),
            ],
          ),
        ),
      ),
    );
  }
}
