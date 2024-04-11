import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:epass/extras/otp_auth.dart';
import 'package:epass/screens/home_page.dart';
import 'package:epass/extras/otp_timer_widget.dart';
import 'package:epass/extras/otp_verification_textfield.dart';
import 'package:epass/extras/otp_number_textfield.dart';
import 'package:epass/extras/otp_verification_textfields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpAuth = OTP();
  final TextEditingController OTPVerificationTextFieldController1 =
      TextEditingController();
  final TextEditingController OTPVerificationTextFieldController2 =
      TextEditingController();
  final TextEditingController OTPVerificationTextFieldController3 =
      TextEditingController();
  final TextEditingController OTPVerificationTextFieldController4 =
      TextEditingController();
  final TextEditingController OTPVerificationTextFieldController5 =
      TextEditingController();
  final TextEditingController OTPVerificationTextFieldController6 =
      TextEditingController();

  final TextEditingController otpNumberController = TextEditingController();
  final TextEditingController otpCountryCodeController =
      TextEditingController();

  @override
  void dispose() {
    OTPVerificationTextFieldController1.dispose();
    OTPVerificationTextFieldController2.dispose();
    OTPVerificationTextFieldController3.dispose();
    OTPVerificationTextFieldController4.dispose();
    OTPVerificationTextFieldController5.dispose();
    OTPVerificationTextFieldController6.dispose();
    // otpNumberController.dispose();
    // otpCountryCodeController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _isChanged = false;
  void continueToHome() {
    if (_formKey.currentState!.validate()) {
      otpAuth.validateOtpAndLogin(context, '');
    }
  }

  String userCountryNumber = '';
  void getUserNumber() {
    final phoneNumber = otpNumberController.text.trim().startsWith('0')
        ? otpNumberController.text.trim().substring(1)
        : otpNumberController.text.trim();
    print(phoneNumber.trim());
    if (_formKey.currentState!.validate()) {
      userCountryNumber =
          "+${otpCountryCodeController.text.trim().toString()}0${phoneNumber}";
      print(userCountryNumber);
    }
  }

  bool verificationCompleted = false;
  bool codeSent = true;

  Future verify() async {
    if (_formKey.currentState!.validate()) {
      if (otpNumberController.text.isNotEmpty &&
          otpCountryCodeController.text.isNotEmpty) {
        print("+$userCountryNumber");
        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
            // phoneNumber: '+ $userCountryNumber',
            phoneNumber: "+2348064788742",
            verificationCompleted: (PhoneAuthCredential credential) {
              setState(() {
                verificationCompleted = true;
              });
            },
            verificationFailed: (FirebaseAuthException error) {
              print(error);
              print(error.code);
              if (error.code == "39") {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("There seems ot be a network problem"),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.message ?? 'Verification failed.'),
                  ),
                );
              }
              setState(() {
                _isChanged = !_isChanged;
              });
            },
            codeSent: (String verificationId, int? resendToken) {
              setState(() {
                codeSent = true;
              });
            },
            codeAutoRetrievalTimeout: (String verificationId) {},
          );
          print("sent");
        } on FirebaseAuthException catch (error) {
          print(error);
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.message ?? 'Verification failed.'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 68.0,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 32.0,
                      color: Color.fromRGBO(74, 73, 74, 1),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              // Sign Up text
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 8.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4.0),
                          bottom: Radius.circular(4.0),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      width: 9.0,
                    ),
                    const Expanded(
                      child: Text(
                        "OTP Verification Screen",
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(
                          color: Color.fromRGBO(74, 73, 74, 1),
                          fontWeight: FontWeight.w400,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 79.0),

              Form(
                key: _formKey,
                onChanged: () {
                  _formKey.currentState!.validate();
                },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 64.0,
                  child: !_isChanged
                      ? OTPNumberTextField(
                          otpNumberController: otpNumberController,
                          otpCountryCodeController: otpCountryCodeController,
                        )
                      : OTPVerificationTextfields(
                          OTPVerificationTextFieldController1:
                              OTPVerificationTextFieldController1,
                          OTPVerificationTextFieldController2:
                              OTPVerificationTextFieldController2,
                          OTPVerificationTextFieldController3:
                              OTPVerificationTextFieldController3,
                          OTPVerificationTextFieldController4:
                              OTPVerificationTextFieldController4,
                          OTPVerificationTextFieldController5:
                              OTPVerificationTextFieldController5,
                          OTPVerificationTextFieldController6:
                              OTPVerificationTextFieldController6,
                        ),
                ),
              ),

              const SizedBox(height: 26.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      Size(MediaQuery.of(context).size.width - 70.0, 59.0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 130.0,
                    vertical: 18.0,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                onPressed: () {
                  setState(
                    () {
                      _formKey.currentState!.validate();
                      if (_isChanged != true) {
                        if (_formKey.currentState!.validate()) {
                          getUserNumber();
                          // verify();
                          print(userCountryNumber + "1");

                          otpAuth.getCodeWithPhoneNumber(
                            context,
                            userCountryNumber,
                          );
                          _isChanged = !_isChanged;
                        }
                      } else {
                        setState(() {
                          continueToHome();
                        });
                      }
                    },
                  );
                },
                child: !_isChanged
                    ? const Text(
                        "Send OTP",
                        style: TextStyle(
                          color: Color.fromRGBO(249, 249, 249, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          fontFamily: 'Karla',
                        ),
                      )
                    : const Text(
                        "Continue",
                        style: TextStyle(
                          color: Color.fromRGBO(249, 249, 249, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0,
                          fontFamily: 'Karla',
                        ),
                      ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    !_isChanged
                        ? "Already entered your phone number?"
                        : "Wrong number?",
                    style: const TextStyle(fontSize: 15.0),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isChanged = !_isChanged;
                        print(_isChanged);
                      });
                    },
                    child: Text(
                      !_isChanged ? "Verify" : "Change",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              _isChanged
                  ? OTPTImerWidget(
                      isDone: _isChanged,
                      executable: () {
                        // otpAuth.getCodeWithPhoneNumber(
                        //   context,
                        //   userCountryNumber,
                        // );
                        setState(() {
                          _isChanged = !_isChanged;
                        });
                      },
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
