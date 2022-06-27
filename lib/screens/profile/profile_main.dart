import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parkspace/constants/colors.dart';
import 'package:parkspace/models/user_data.dart';
import 'package:parkspace/providers/user_provider.dart';
import 'package:parkspace/widgets/button.dart';
import 'package:parkspace/widgets/greetings.dart';
import 'package:parkspace/widgets/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../utils/globals.dart';
import '../authentication/login_page.dart';
import 'package:provider/provider.dart';

class ProfileMain extends StatefulWidget {
  ProfileMain({Key? key}) : super(key: key);

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      UserData user = context.read<UserProvider>().currentUser!;
      nameController.text = user.name;
      emailController.text = user.email;
      phoneController.text = user.phone;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                  width: 100.w,
                  child: Stack(
                    children: [
                      const GreetingsWidget(
                        "Administrator",
                        isProfile: true,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 6.w,
                            width: 6.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: kSecondaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.close,
                              size: 4.w,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                CTextField(
                  controller: nameController,
                  hint: "Name",
                ),
                CTextField(
                  controller: emailController,
                  hint: "Email",
                ),
                CTextField(
                  controller: phoneController,
                  hint: "Phone",
                ),
                SizedBox(height: 2.h),
                Consumer<UserProvider>(builder: (context, provider, child) {
                  return CButton(
                    isLoading: provider.updatingUser,
                    isDisabled: provider.updatingUser,
                    title: "Update",
                    onTap: () {
                      provider.updateUser(
                        user: UserData(
                          email: provider.currentUser!.email,
                          name: nameController.text,
                          phone: phoneController.text,
                          type: provider.currentUser!.type,
                          id: provider.currentUser!.id,
                        ),
                        onSuccess: (val) {
                          Navigator.pop(context);
                          Globals.showCustomDialog(
                            context: context,
                            title: "Success",
                            content: val,
                          );
                        },
                        onError: (val) {
                          Navigator.pop(context);
                          Globals.showCustomDialog(
                            context: context,
                            title: "Error",
                            content: val,
                          );
                        },
                      );
                    },
                  );
                }),
                SizedBox(height: 6.h),
                InkWell(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    SharedPreferences localdb = await SharedPreferences.getInstance();
                    localdb.clear();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                        (route) => false);
                  },
                  child: SizedBox(
                    height: 5.h,
                    child: Row(
                      children: [
                        Text(
                          "Signout",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
