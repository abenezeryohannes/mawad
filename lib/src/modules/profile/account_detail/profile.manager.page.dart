import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mawad/src/core/models/user.dart';
import 'package:mawad/src/modules/auth/register/register_with_phone_controller.dart';
import 'package:mawad/src/modules/profile/widgets/profile.avatar.dart';
import 'package:mawad/src/modules/profile/widgets/profile.text.input.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return Column(
                    children: [
                      _appBar(context),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ProfileAvatar(
                          radius: 50,
                          onImagePicked: (p0) {},
                        ),
                      ),
                      ProfileTextInput(
                          label: 'Full Name',
                          controller: controller.nameController,
                          placeholder:
                              controller.userDetail.value!.name.toString(),
                          onChange: (text) {
                            controller.nameController.text = text;
                          }),
                      //todo change this to phone
                      ProfileTextInput(
                          isEnabled: false,
                          label: 'Phone',
                          initialText:
                              controller.userDetail.value!.phone.toString(),
                          onChange: (text) {}),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(() {
                        return BigTextButton(
                            text: 'Save',
                            fontWight: FontWeight.bold,
                            cornerRadius: 24,
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
                              controller.updateUserDetail(UserModel(
                                phone: controller.userDetail.value!.phone,
                                name: controller.nameController.text,
                              ));
                            });
                      })
                    ],
                  );
                }),
                SizedBox(
                  height: 100.h,
                ),
                BigTextButton(
                    text: 'Log out',
                    fontWight: FontWeight.bold,
                    cornerRadius: 16,
                    elevation: 0,
                    backgroudColor: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: Theme.of(context).cardColor,
                    textColor: Theme.of(context).hintColor,
                    padding: const EdgeInsets.only(top: 17, bottom: 17),
                    horizontalMargin:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    onClick: () {
                      controller.logout();
                    })
              ],
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
