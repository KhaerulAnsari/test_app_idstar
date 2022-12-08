import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:provider/provider.dart';
import 'package:tes_app_idstar/models/user_model.dart';
import 'package:tes_app_idstar/providers/user_provder.dart';
import 'package:tes_app_idstar/theme.dart';
import 'package:tes_app_idstar/ui/pages/create_user_page.dart';
import 'package:tes_app_idstar/ui/widgets/card_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  List<UserModel> list = [];

  onSearching(
    String query,
  ) {
    final suggestions = list.where((data) {
      final dataName = data.name!.toLowerCase();
      final input = query.toLowerCase();

      return dataName.contains(input);
    }).toList();

    setState(() {
      list = suggestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    textWelcome() {
      return Text(
        "Hello,",
        style: blackTextStyle.copyWith(
          fontSize: 28,
          fontWeight: semiBold,
          color: blueColor,
        ),
      );
    }

    textTest() {
      return Text(
        "Welcome to my test App.",
        style: greyTextStyle.copyWith(
          fontSize: 22,
          fontWeight: medium,
        ),
      );
    }

    formSearch() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF1F0F5),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Icon(Icons.search),
            Expanded(
              child: ListTile(
                title: TextField(
                  style: blackTextStyle.copyWith(),
                  controller: searchController,
                  onChanged: onSearching,
                  decoration: InputDecoration(
                      hintText: "Search Users...",
                      border: InputBorder.none,
                      hintStyle: greyTextStyle.copyWith()),
                ),
                trailing: IconButton(
                  onPressed: () {
                    searchController.clear();
                    onSearching('');
                  },
                  icon: const Icon(
                    Icons.clear,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    listUser() {
      return Expanded(
        child: searchController.text.isNotEmpty
            ? ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return UserCard(
                    userData: list[index],
                  );
                },
              )
            : FutureBuilder<List<UserModel>>(
                future: userProvider.getListUser(),
                builder: (context, snapshoot) {
                  if (snapshoot.connectionState == ConnectionState.done) {
                    list.addAll(snapshoot.data!.reversed);

                    return ListView.builder(
                      itemCount: snapshoot.data!.length,
                      itemBuilder: (context, index) {
                        return UserCard(
                          userData: snapshoot.data![index],
                        );
                      },
                    );
                  }

                  list.clear();

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(
              const CreateUserPage(),
            );
          },
          backgroundColor: blueColor,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              textWelcome(),
              const SizedBox(
                height: 5,
              ),
              textTest(),
              const SizedBox(
                height: 15,
              ),
              formSearch(),
              const SizedBox(
                height: 30,
              ),
              listUser(),
            ],
          ),
        ),
      ),
    );
  }
}
