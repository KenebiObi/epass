import 'dart:math';

import 'package:flutter/material.dart';
import 'package:epass/widgets/character_option.dart';
import 'package:epass/widgets/copy_password_button.dart';
import 'package:epass/widgets/number_picker_widget.dart';
import 'package:epass/widgets/save_password_button.dart';
import 'package:epass/widgets/gen_screen_add_pass_dialog.dart';

class GeneratepasswordScreen extends StatefulWidget {
  const GeneratepasswordScreen();

  @override
  State<GeneratepasswordScreen> createState() => _GeneratepasswordScreenState();
}

class _GeneratepasswordScreenState extends State<GeneratepasswordScreen> {
  bool _addUpperCase = false;
  bool _addLowerCase = false;
  bool _addNumbers = false;
  bool _addSymbols = false;
  int mainValue = 0;

  String _allCharacters =
      '!@#\$%^&*()_+qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890';
  String _allLowerCaseChars = 'qwertyuiopasdfghjklzxcvbnm';
  String _randomPassword = "password";

  // Main password to be saved in firebase
  String _password = '';

  Map<String, String> theMap = {
    'lower': 'qwertyuiopasdfghjklzxcvbnm',
    'upper': 'QWERTYUIOPASDFGHJKLZXCVBNM',
    'nums': '1234567890',
    'special': '!@#\$%^&*()_+',
  };

  List options = [];

  void generatepassword() {
    String generatedCharacters = "";

    int remainingLength = mainValue.round();

    if (options.isNotEmpty) {
      while (remainingLength > 0) {
        for (var option in options) {
          if (remainingLength > 0) {
            String randomChar =
                theMap[option]![Random().nextInt(theMap[option]!.length)];
            generatedCharacters += randomChar;
            remainingLength--;
          }
        }
      }
    } else {
      for (int i = 0; i < mainValue; i++) {
        generatedCharacters +=
            _allLowerCaseChars[Random().nextInt(_allLowerCaseChars.length)];
      }
    }

    List<String> listOfGeneratedChars = generatedCharacters.split('');
    listOfGeneratedChars.shuffle(Random());
    String shuffledString = listOfGeneratedChars.join('');
    _randomPassword =
        shuffledString.substring(0, mainValue); // Trim to desired length

    if (_randomPassword.isEmpty) {
      _randomPassword = "password";
      print("Password set to 'password'");
    }
  }

  final TextEditingController _accountController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _accountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (ctx, constraints) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 15.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 30.0,
                            top: 20.0,
                          ),
                          child: Row(
                            children: [
                              const Spacer(),
                              Text(
                                ("${mainValue.toString()} Characters"),
                                // constraints.maxHeight.toString(),
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Flexible(
                            child: Text(
                              _randomPassword,
                              style: TextStyle(
                                fontSize:
                                    _randomPassword.length > 13 ? 20.0 : 30.0,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10.0,
                            bottom: 10.0,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    generatepassword();
                                  });
                                },
                                icon: Icon(
                                  Icons.autorenew,
                                  size: 30.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                              // const Spacer()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  CharacterOptionWidget(
                    icon: Icons.text_fields_rounded,
                    color: _addLowerCase
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).colorScheme.background,
                    chracterSelection: "Add lower case characters",
                    onTap: () {
                      setState(() {
                        _addLowerCase = !_addLowerCase;
                      });

                      print(_addLowerCase);
                      if (_addLowerCase) {
                        options.add('lower');
                      } else {
                        options.remove('lower');
                      }
                    },
                  ),
                  CharacterOptionWidget(
                    icon: Icons.text_fields_rounded,
                    color: _addUpperCase
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).colorScheme.background,
                    chracterSelection: "Add upper case characters",
                    onTap: () {
                      setState(() {
                        _addUpperCase = !_addUpperCase;
                      });

                      print(_addUpperCase);
                      if (_addUpperCase) {
                        options.add('upper');
                      } else {
                        options.remove('upper');
                      }
                    },
                  ),
                  CharacterOptionWidget(
                    icon: Icons.looks_one_rounded,
                    color: _addNumbers
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).colorScheme.background,
                    chracterSelection: "Add numbers",
                    onTap: () {
                      setState(() {
                        _addNumbers = !_addNumbers;
                      });

                      print(_addUpperCase);
                      if (_addNumbers) {
                        options.add('nums');
                      } else {
                        options.remove('nums');
                      }
                    },
                  ),
                  CharacterOptionWidget(
                    icon: Icons.star_rate_rounded,
                    color: _addSymbols
                        ? Theme.of(context).primaryColorLight
                        : Theme.of(context).colorScheme.background,
                    chracterSelection: "Add special characters",
                    onTap: () {
                      setState(() {
                        _addSymbols = !_addSymbols;
                      });
                      print(_addUpperCase);
                      if (_addSymbols) {
                        options.add('special');
                      } else {
                        options.remove('special');
                      }
                    },
                  ),
                  constraints.maxWidth < 410
                      ? const SizedBox(height: 15.0)
                      : const SizedBox(),
                  constraints.maxWidth < 410
                      ? Text(
                          "Slide to generate",
                          // constraints.maxWidth.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15.0),
                  constraints.maxWidth < 410.0
                      ? SizedBox(
                          width: constraints.maxWidth - 15,
                          child: NumberPickerWidget(
                            mainValue: mainValue,
                            executable: (newValue) {
                              setState(
                                () {
                                  mainValue = newValue;
                                  print(mainValue);
                                  generatepassword();
                                },
                              );
                            },
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CopyPasswordButton(clipBoardText: _randomPassword),
                            const SizedBox(width: 30.0),
                            NumberPickerWidget(
                              mainValue: mainValue,
                              executable: (newValue) {
                                setState(
                                  () {
                                    mainValue = newValue;
                                    print(mainValue);
                                    generatepassword();
                                  },
                                );
                              },
                            ),
                            const SizedBox(width: 30.0),
                            SavepasswordButton(
                              onTap: () {
                                _password = _randomPassword; // MAIN PASSWORD
                                showDialog(
                                  context: context,
                                  builder: (context) => GenScreenAddPassDialog(
                                    controller: _accountController,
                                    passwordText: _password,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                  constraints.maxWidth <= 410
                      ? const SizedBox(height: 15.0)
                      : const SizedBox(),
                  constraints.maxWidth < 410
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CopyPasswordButton(
                              clipBoardText: _randomPassword,
                            ),
                            const SizedBox(width: 15.0),
                            SavepasswordButton(
                              onTap: () {
                                _password = _randomPassword; // MAIN PASSWORD
                                showDialog(
                                  context: context,
                                  builder: (context) => GenScreenAddPassDialog(
                                    controller: _accountController,
                                    passwordText: _password,
                                  ),
                                );
                              },
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 15.0),
                  constraints.maxWidth < 410
                      ? const SizedBox()
                      : const Text(
                          "Slide left to generate",
                          // constraints.maxWidth.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
