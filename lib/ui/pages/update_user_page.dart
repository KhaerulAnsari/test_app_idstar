import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tes_app_idstar/models/user_model.dart';
import 'package:tes_app_idstar/providers/user_provder.dart';
import 'package:tes_app_idstar/theme.dart';
import 'package:tes_app_idstar/ui/widgets/custom_button.dart';
import 'package:tes_app_idstar/ui/widgets/custom_textfield.dart';
import 'package:tes_app_idstar/ui/widgets/info_dialog.dart';
import 'package:tes_app_idstar/ui/widgets/succes_dialog.dart';

class UpdateUserPage extends StatefulWidget {
  UserModel? userData;
  UpdateUserPage({super.key, this.userData});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  List<String> statusTypeList = ['active', 'inactive'];
  String? selectedStatusType;
  List<String> genderTypeList = ['male', 'female'];
  String? selectedgenderType;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);

    textHeader() {
      return Text(
        "Edit User",
        style: blackTextStyle.copyWith(
          fontSize: 28,
          fontWeight: semiBold,
          color: blueColor,
        ),
        textAlign: TextAlign.center,
      );
    }

    formName() {
      return CustomTextField(
        title: 'Name',
        hintText: 'Type your name...',
        textEditingController: nameController
          ..text = widget.userData!.name.toString(),
      );
    }

    formEmail() {
      return CustomTextField(
        title: 'Email',
        hintText: 'Type your email...',
        textEditingController: emailController
          ..text = widget.userData!.email.toString(),
      );
    }

    selectedGender() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Gender',
            style: textStyle.copyWith(
              fontSize: 16,
              color: blackColor,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          // TextField
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F0F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton(
              isExpanded: true,
              dropdownColor: whiteColor,
              iconSize: 20,
              underline: const SizedBox(),
              hint: Text(
                widget.userData!.gender.toString(),
                style: greyTextStyle.copyWith(),
              ),
              value: selectedgenderType ?? widget.userData!.gender.toString(),
              items: genderTypeList.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: blackTextStyle.copyWith(),
                    ),
                  );
                },
              ).toList(),
              onChanged: (newValue) {
                setState(
                  () {
                    selectedgenderType = newValue.toString();
                  },
                );
              },
              focusColor: const Color(0xFF707070),
            ),
          ),
        ],
      );
    }

    selectedStatus() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Status',
            style: textStyle.copyWith(
              fontSize: 16,
              color: blackColor,
            ),
          ),

          const SizedBox(
            height: 6,
          ),

          // TextField
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F0F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton(
              isExpanded: true,
              dropdownColor: whiteColor,
              iconSize: 20,
              underline: const SizedBox(),
              hint: Text(
                widget.userData!.status.toString(),
                style: greyTextStyle.copyWith(),
              ),
              value: selectedStatusType ?? widget.userData!.status.toString(),
              items: statusTypeList.map(
                (e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                      style: blackTextStyle.copyWith(),
                    ),
                  );
                },
              ).toList(),
              onChanged: (newValue) {
                setState(
                  () {
                    selectedStatusType = newValue.toString();
                  },
                );
              },
              focusColor: const Color(0xFF707070),
            ),
          ),
        ],
      );
    }

    buttonEditUser() {
      return isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: blueColor,
              ),
            )
          : SizedBox(
              height: 45,
              width: double.infinity,
              child: CustomButton(
                onPressed: () {
                  setState(
                    () {
                      isLoading = true;
                    },
                  );

                  userProvider.updateUser(
                    int.parse(
                      widget.userData!.id.toString(),
                    ),
                    {
                      'email': emailController.text.trim(),
                      'name': nameController.text.trim(),
                      'gender': genderController.text =
                          selectedgenderType == null
                              ? widget.userData!.gender ?? ''
                              : selectedgenderType.toString(),
                      'status': statusController.text =
                          selectedStatusType == null
                              ? widget.userData!.status ?? ''
                              : selectedStatusType.toString(),
                    },
                  );

                  Get.back();

                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (c) {
                      return const SuccesDialog(
                        message: "Berhasil mengubah data user",
                      );
                    },
                  );
                },
                color: blueColor,
                title: 'Edit User',
              ),
            );
    }

    buttonDeleteUser() {
      return SizedBox(
        height: 45,
        width: double.infinity,
        child: CustomButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  return InfoDialog(
                    message:
                        'Apakah anda ingin menghapus ${widget.userData!.name}?',
                    onPressed: () {
                      setState(
                        () {
                          isLoading = true;
                        },
                      );

                      userProvider.deleteUser(widget.userData!.id!);

                      Get.back();
                      Get.back();

                      showDialog(
                        context: context,
                        builder: (c) {
                          return const SuccesDialog(
                            message: "Berhasil menghapus user.",
                          );
                        },
                      );
                    },
                  );
                },
              );
            },
            color: redColor,
            title: 'Hspus User'),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              textHeader(),
              const SizedBox(
                height: 15,
              ),
              formName(),
              const SizedBox(
                height: 8,
              ),
              formEmail(),
              const SizedBox(
                height: 8,
              ),
              selectedGender(),
              const SizedBox(
                height: 8,
              ),
              selectedStatus(),
              const SizedBox(
                height: 20,
              ),
              buttonEditUser(),
              const SizedBox(
                height: 15,
              ),
              buttonDeleteUser(),
            ],
          ),
        ),
      ),
    );
  }
}
