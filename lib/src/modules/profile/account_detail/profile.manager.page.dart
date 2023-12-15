import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/profile/widgets/profile.avatar.dart';
import 'package:mawad/src/modules/profile/widgets/profile.text.input.dart';
import 'package:mawad/src/presentation/sharedwidgets/custome_snack.dart';
import 'package:mawad/src/presentation/theme/textTheme.dart';

import '../../../presentation/sharedwidgets/big.text.button.dart';

class ProfileManagerPage extends GetView<RegisterWithPhoneController> {
  const ProfileManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getUserDetail();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: controller.formKeyA,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      _appBar(context),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ProfileAvatar(
                          radius: 50,
                          imageUrl: controller.userDetail.value?.avatar == null
                              ? null
                              : "http://ordermawad.com/api/v1/file/get/${controller.userDetail.value?.avatar}",
                          onImagePicked: (p0) {
                            controller.addAvatar(p0);
                          },
                        ),
                      ),
                      ProfileTextInput(
                          label: 'Full Name',
                          controller: controller.nameController,
                          initialText:
                              controller.userDetail.value?.name.toString(),
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter valid name';
                            }
                          },
                          onChange: (text) {}),
                      ProfileTextInput(
                          label: 'Phone',
                          readolny: true,
                          placeholder: 'Phone',
                          controller: controller.phonecontroller,
                          initialText:
                              controller.userDetail.value?.phone.toString(),
                          onChange: (text) {}),
                      ProfileTextInput(
                          controller: controller.emailController,
                          label: 'Email',
                          placeholder: 'Email',
                          initialText:
                              controller.userDetail.value?.userEmail.toString(),
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return 'Please enter valid email';
                            } else if (!p0.isEmail) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          onChange: (text) {}),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return BigTextButton(
                            text: 'Save',
                            fontWight: FontWeight.bold,
                            cornerRadius: 24,
                            fontSize: 18,
                            isLoading: controller.isLoading.value,
                            elevation: 0,
                            backgroudColor:
                                Theme.of(context).colorScheme.secondary,
                            borderColor: Theme.of(context).cardColor,
                            textColor:
                                Theme.of(context).colorScheme.onBackground,
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            horizontalMargin: const EdgeInsets.only(
                                left: 30, right: 30, bottom: 10),
                            onClick: () {
                              if (controller.formKeyA.currentState!
                                  .validate()) {
                                if ((controller
                                            .nameController.text.isNotEmpty ||
                                        controller.userDetail.value?.name !=
                                            null) &&
                                    (controller
                                            .emailController.text.isNotEmpty ||
                                        controller
                                                .userDetail.value?.userEmail !=
                                            null)) {
                                  controller.updateUserDetail(UserModel(
                                    phone: controller.userDetail.value?.phone,
                                    name: controller
                                            .nameController.text.isNotEmpty
                                        ? controller.nameController.text
                                        : controller.userDetail.value?.name,
                                    userEmail: controller
                                            .emailController.text.isNotEmpty
                                        ? controller.emailController.text
                                        : controller
                                            .userDetail.value?.userEmail,
                                  ));
                                }
                              } else {
                                showCustomSnackbar(
                                    title: "Error",
                                    message: "Please fill all fields");
                              }
                            });
                      })
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  BigTextButton(
                      text: 'Delete Account',
                      fontWight: FontWeight.bold,
                      cornerRadius: 16,
                      elevation: 0,
                      fontSize: 18,
                      backgroudColor: Theme.of(context).scaffoldBackgroundColor,
                      borderColor: Theme.of(context).cardColor,
                      textColor: Theme.of(context).hintColor,
                      padding: const EdgeInsets.only(top: 17, bottom: 17),
                      horizontalMargin: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10),
                      onClick: () {
                        //check if user need to delete account
                        Get.dialog(
                          AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text(
                                'Are you sure you want to delete your account?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  'Cancel',
                                  style: AppTextTheme.yellow14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  controller.logout();
                                  Get.back();
                                },
                                child: Text(
                                  'Delete',
                                  style: AppTextTheme.yellow14,
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                ],
              ),
            ),
          ),
        ));
  }

  Widget _appBar(context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 20, right: 20, top: 10.0, bottom: 10),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
                onTap: () {
                  // Get.to(const ProfilePage());
                  Get.back();
                },
                child: const Icon(
                  Icons.chevron_left,
                  size: 32,
                )),
            Expanded(
              child: Text(
                'Edit Profile',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
