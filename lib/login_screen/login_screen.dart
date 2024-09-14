import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_container/home_container.dart';
import '../widget/use_provider.dart';
import 'local_notification_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _nameKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final GlobalKey<FormState> _phoneKey = GlobalKey<FormState>();

  String generatedOtp = '';

  @override
  void initState()  {
    super.initState();
    generatedOtp = generateOTP(4);// توليد OTP عند تشغيل التطبيق
    navigatorPage();
  }

  void saveLoginDetails(String name, String phone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Save login status
    await prefs.setString('userName', name); // Save user name
    await prefs.setString('userPhone', phone); // Save user phone number
  }

  // توليد OTP
  String generateOTP([int length = 4]) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }

  // التحقق من إدخال المستخدم
  Future<void> verifyOtp() async {
    if (otpController.text == generatedOtp) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP is correct!')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeContainer(),
        ),
      );
      saveLoginDetails(_nameController.text,phoneController.text);
      // هنا يمكن الانتقال إلى الشاشة التالية أو إتمام عملية التسجيل
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP! Please try again.')),
      );
    }
  }

  //التحقق من اسم المستخدم
 String? validatorName(String? value){
   if(value == null || value.isEmpty){
     return "please Enter Your Name";
   }
   return null;
 }

// Check login details function
  Future<Map<String, dynamic>> checkLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userName = prefs.getString('userName');
    String? userPhone = prefs.getString('userPhone');

    return {
      'isLoggedIn': isLoggedIn,
      'userName': userName,
      'userPhone': userPhone,
    };
  }

  navigatorPage() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userName = prefs.getString('userName');

    if(isLoggedIn && userName!=null){
      Provider.of<UserProvider>(context, listen: false).setUserName(userName);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeContainer(),));
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // await prefs.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Goal!",
                      style: TextStyle(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 60),
                    Form(
                      key: _nameKey,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 35, right: 10),
                        child: SizedBox(
                          width: 310,
                          child: TextFormField(
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: "Please Enter Your Name",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.grey),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.red,
                                  width: 3,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 3
                                ),
                              ),
                            ),
                            validator: validatorName,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 90),
                    Form(
                      key: _phoneKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "asset/images/syria_flag.png",
                            width: 23,
                            height: 23,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              maxLength: 10,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, top: 11),
                                  child: Text(
                                    "+963",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                hintText: "Enter Your Phone number",
                                hintStyle: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.grey,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.grey),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 3,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Colors.red,
                                    width: 3
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter Phone Number";
                                } else if (value.length != 10) {
                                  return 'Phone number must be 10 digits';
                                } else if (value[0] != '0' && value[1] != '9') {
                                  return "phone number must start with 09";
                                } else if (value.contains('*') ||
                                    value.contains('#') ||
                                    value.contains(' ')) {
                                  return "phone number must be number only";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton (
                      onPressed: () {
                        if (_phoneKey.currentState!.validate()&&_nameKey.currentState!.validate()) {
                          NotificationService.showNotification(
                              title: "Goal App",
                              body:
                                  " رمز التأكيد الخاص بك للدخول للتطبيق هو $generatedOtp",
                              payload: "kasmlksamlkm",
                          );
                          Provider.of<UserProvider>(context, listen: false)
                              .setUserName(_nameController.text);

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text("Send SMS"),
                    ),
                    const SizedBox(height: 70),
                    Padding(
                      padding: const EdgeInsets.only(left: 35, right: 10),
                      child: SizedBox(
                        width: 310,
                        child: TextFormField(
                          controller: otpController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter SMS";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.password,
                              color: Colors.grey,
                            ),
                            hintText: "Please Enter SMS",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(100, 40),
                      ),
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
