import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tes_app_idstar/providers/user_provder.dart';
import 'package:tes_app_idstar/theme.dart';
import 'package:tes_app_idstar/ui/widgets/custom_button.dart';
import 'package:tes_app_idstar/ui/widgets/custom_textfield.dart';
import 'package:tes_app_idstar/ui/widgets/snackbar_box.dart';
import 'package:tes_app_idstar/ui/widgets/succes_dialog.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  List<String> genderTypeList = ['male', 'female'];
  String? selectedgenderType;
  List<String> statusTypeList = ['active', 'inactive'];
  String? selectedStatusType;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    textHeader() {
      return Text(
        "Create New User",
        style: blackTextStyle.copyWith(
          fontSize: 28,
          fontWeight: semiBold,
          color: blueColor,
        ),
        textAlign: TextAlign.center,
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
                "Satuan",
                style: greyTextStyle.copyWith(),
              ),
              value: selectedgenderType,
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
                    genderController.text = newValue.toString();
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
                "Select Status",
                style: greyTextStyle.copyWith(),
              ),
              value: selectedStatusType,
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
                    statusController.text = newValue.toString();
                  },
                );
              },
              focusColor: const Color(0xFF707070),
            ),
          ),
        ],
      );
    }

    falidateVorm() {
      if (nameController.text.isEmpty ||
          emailController.text.isEmpty ||
          genderController.text.isEmpty ||
          statusController.text.isEmpty) {
        snackbarBox("Form cannot be empty.");
      } else if (!EmailValidator.validate(emailController.text)) {
        snackbarBox("Format email tidak valid.");
      } else {
        setState(
          () {
            isLoading = true;
          },
        );

        userProvider.createUser(
          {
            'name': nameController.text.trim(),
            'email': emailController.text.trim(),
            'gender': genderController.text.trim(),
            'status': statusController.text.trim(),
          },
        );

        Get.back();

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (c) {
            return const SuccesDialog(
              message: "Berhasil menambahkan user",
            );
          },
        );
      }
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
                height: 15,
              ),
              textHeader(),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                title: 'Name',
                hintText: 'Type your name...',
                textEditingController: nameController,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextField(
                title: 'Email',
                hintText: 'Type your email...',
                textEditingController: emailController,
              ),
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
              isLoading
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
                          falidateVorm();
                        },
                        color: blueColor,
                        title: 'Create User',
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
