import 'package:epass/backend/database_service.dart';
import 'package:flutter/material.dart';
import 'package:epass/backend/user_details.dart';
import 'package:epass/widgets/save_pass_bottom_sheet.dart';
import 'package:epass/widgets/save_screen_edit_pass_dialog.dart';
import 'package:epass/widgets/saved_password_tile.dart';

class SavepasswordScreen extends StatefulWidget {
  SavepasswordScreen({required saveDetails});

  @override
  State<SavepasswordScreen> createState() => _SavepasswordScreenState();
}

class _SavepasswordScreenState extends State<SavepasswordScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _editAccountController = TextEditingController();
  final TextEditingController _editPasswordController = TextEditingController();

  final DataBaseServices _databaseServices = DataBaseServices();

  bool isVisible = false;

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    _editAccountController.dispose();
    _editPasswordController.dispose();
    super.dispose();
  }

  void restoreDeletedUserDetails(
    List userDetails,
    String userdetailId,
    UserDetails userdetail,
    int index,
  ) {
    if (index >= 0 && index < userDetails.length) {
      print("Deleted");
      setState(() {
        try {
          // Show a SnackBar to notify the user and provide an option to undo the deletion
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 4),
              content: const Text("Password deleted"),
              action: SnackBarAction(
                label: "Undo",
                onPressed: () async {
                  // Decrypt the password before adding it back to Firestore
                  final decryptedPassword =
                      _databaseServices.decryptPassword(userdetail.password);
                  final userDetailsToRestore =
                      userdetail.copyWith(password: decryptedPassword);
                  _databaseServices.addUserDetails(userDetailsToRestore);
                },
              ),
              dismissDirection: DismissDirection.horizontal,
            ),
          );
        } catch (error) {
          // Handle error
          print("Error restoring password: $error");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Failed to restore password: $error"),
            ),
          );
        }
      });
    }
  }

  int userDetailsLength = 0;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                          //  constraints.maxWidth <= 378
                          //     ? ElevatedButton(
                          //         style: ElevatedButton.styleFrom(
                          //           minimumSize: const Size(double.infinity, 60.0),
                          //         ),
                          //         onPressed: () {
                          //           Brightness brightness =
                          //               MediaQuery.of(context).platformBrightness;
                          //           bool isDarkMode = brightness == Brightness.dark;
                          //           showModalBottomSheet(
                          //             isScrollControlled: true,
                          //             showDragHandle: true,
                          //             backgroundColor: isDarkMode
                          //                 ? Theme.of(context).colorScheme.background
                          //                 : Colors.blue[50],
                          //             useSafeArea: true,
                          //             context: context,
                          //             builder: (ctx) => SavepassBottomSheetWidget(
                          //               accountController: _accountController,
                          //               passwordController: _passwordController,
                          //               executable: () {
                          //                 setState(() {});
                          //               },
                          //             ),
                          //           );
                          //         },
                          //         child: const Icon(Icons.add),
                          //       )
                          //     :
                          ElevatedButton.icon(
                        onPressed: () {
                          Brightness brightness =
                              MediaQuery.of(context).platformBrightness;
                          bool isDarkMode = brightness == Brightness.dark;
                          showModalBottomSheet(
                            isScrollControlled: true,
                            showDragHandle: true,
                            backgroundColor: isDarkMode
                                ? Theme.of(context).colorScheme.background
                                : Colors.blue[50],
                            useSafeArea: true,
                            context: context,
                            builder: (ctx) => SavepassBottomSheetWidget(
                              accountController: _accountController,
                              passwordController: _passwordController,
                              executable: () {
                                setState(() {});
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60.0),
                        ),
                        icon: const Icon(Icons.add),
                        label: Text(
                          // constraints.maxWidth <= 378
                          //     ? "Create":
                          "Create Password",
                          style: TextStyle(
                            fontSize: constraints.maxWidth <= 378 ? 15.0 : 18.0,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: constraints.maxWidth * 0.08,
                    // ),
                    // Text(
                    //   userDetailsLength == 0
                    //       ? "No Passwords"
                    //       : userDetailsLength > 1
                    //           ? "$userDetailsLength Password"
                    //           : "$userDetailsLength Passwords",
                    //   style: const TextStyle(
                    //     fontSize: 23.0,
                    //   ),
                    // ),
                  ],
                ),
                // Text(
                //   constraints.maxWidth.toString(),
                // ),
                const SizedBox(
                  height: 15.0,
                ),
                const Text(
                  "Slide tiles left to delete item",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: deviceHeight * 0.76,
                    child: StreamBuilder(
                      stream: _databaseServices.getUserDetails(),
                      builder: (ctx, snapshot) {
                        List userDetails = snapshot.data?.docs ?? [];
                        userDetailsLength = userDetails.length;
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(
                            child: Text("Error fetching data"),
                          );
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                            child: Text("Nothing here"),
                          );
                        } else {
                          print(userDetails);
                          if (userDetails.isEmpty) {
                            return const Center(
                              child: Text("Nothing here"),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: userDetails.length,
                            itemBuilder: (ctx, index) {
                              UserDetails userdetail =
                                  userDetails[index].data();
                              String userdetailId = userDetails[index].id;
                              final decryptedPassword = _databaseServices
                                  .decryptPassword(userdetail.password);

                              print(userdetail.password);
                              return Column(
                                children: [
                                  Dismissible(
                                    key: ValueKey(userDetails[index]),
                                    onDismissed: (direction) {
                                      setState(() {
                                        _databaseServices
                                            .deleteUserDetails(userdetailId);
                                        restoreDeletedUserDetails(
                                          userDetails,
                                          userdetailId,
                                          userdetail,
                                          index,
                                        );
                                      });
                                    },
                                    child: SavedPasswordTileWidget(
                                      altFunction: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              SaveScreenEditPassDialog(
                                            controller: _editAccountController,
                                            password: _editPasswordController,
                                            executable: () {
                                              setState(() {
                                                UserDetails updatedUserDetails =
                                                    userdetail.copyWith(
                                                  account:
                                                      _editAccountController
                                                          .text
                                                          .trim(),
                                                  password:
                                                      _editPasswordController
                                                          .text
                                                          .trim(),
                                                );
                                                _databaseServices
                                                    .updateUserDetails(
                                                  userdetailId,
                                                  updatedUserDetails,
                                                );
                                              });
                                            },
                                          ),
                                        );
                                      },
                                      userdetail: userdetail,
                                      passwordForCopy: decryptedPassword,
                                      encryptedPassword: userdetail.password,
                                      index: 1,
                                    ),
                                  ),
                                  const SizedBox(height: 8.5),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
