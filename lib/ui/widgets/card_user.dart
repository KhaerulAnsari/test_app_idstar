import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tes_app_idstar/models/user_model.dart';
import 'package:tes_app_idstar/providers/user_provder.dart';
import 'package:tes_app_idstar/theme.dart';
import 'package:tes_app_idstar/ui/pages/detail_user_page.dart';
import 'package:tes_app_idstar/ui/pages/update_user_page.dart';
import 'package:tes_app_idstar/ui/widgets/info_dialog.dart';
import 'package:tes_app_idstar/ui/widgets/succes_dialog.dart';

class UserCard extends StatelessWidget {
  UserModel? userData;

  UserCard({super.key, this.userData});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          DetailUserPage(
            userData: userData,
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData!.id!.toString(),
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userData!.name!,
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userData!.email!,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userData!.gender!,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userData!.status!,
                    style: greyTextStyle.copyWith(
                      fontWeight: light,
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  Get.to(
                    UpdateUserPage(
                      userData: userData,
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                ),
              ),
              // Column(
              //   children: [
              //     IconButton(
              //       onPressed: () {
              //         Get.to(
              //           UpdateUserPage(
              //             userData: userData,
              //           ),
              //         );
              //       },
              //       icon: const Icon(
              //         Icons.edit,
              //       ),
              //     ),
              //     IconButton(
              //       onPressed: () {
              //         showDialog(
              //           context: context,
              //           barrierDismissible: false,
              //           builder: (c) {
              //             return InfoDialog(
              //               message:
              //                   'Apakah anda yakin ingin menghapus ${userData!.name}?',
              //               onPressed: () {
              //                 Provider.of<UserProvider>(context, listen: false)
              //                     .deleteUser(
              //                   int.parse(
              //                     userData!.id.toString(),
              //                   ),
              //                 );

              //                 Get.back();

              //                 showDialog(
              //                   context: context,
              //                   barrierDismissible: false,
              //                   builder: (c) {
              //                     return const SuccesDialog(
              //                       message: "Berhasil menghapus laporan",
              //                     );
              //                   },
              //                 );
              //               },
              //             );
              //           },
              //         );
              //       },
              //       icon: const Icon(
              //         Icons.delete,
              //         color: Colors.red,
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
