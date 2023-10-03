import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mawad/src/appcore/widgets/big.text.button.dart';
import 'package:mawad/src/presentation/profile/widgets/profile.avatar.dart';
import 'package:mawad/src/presentation/profile/widgets/profile.text.input.dart';

class ProfileManagerPage extends StatefulWidget {
  const ProfileManagerPage({super.key});

  @override
  State<ProfileManagerPage> createState() => _ProfileManagerPageState();
}

class _ProfileManagerPageState extends State<ProfileManagerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  _appBar(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ProfileAvatar(
                      isLoading: (bool x) {},
                      editable: true,
                      deletable: false,
                      onSave: () {},
                      placeholder: Image.asset(
                        'assets/icon/image_placeholder.png',
                        height: 100,
                        width: 100,
                      ),
                      localImage: '',
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      radius: 100,
                      boxShadow: [],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      upload: (String _) {},
                    ),
                  ),
                  ProfileTextInput(
                      label: 'This is label',
                      placeholder: 'This is placeholder',
                      onChange: (text) {}),
                  ProfileTextInput(
                      label: 'This is label',
                      initialText: '+965242424',
                      onChange: (text) {}),
                  const SizedBox(
                    height: 20,
                  ),
                  BigTextButton(
                      text: 'This is the button',
                      fontWight: FontWeight.bold,
                      cornerRadius: 24,
                      elevation: 0,
                      backgroudColor: Theme.of(context).colorScheme.secondary,
                      borderColor: Theme.of(context).cardColor,
                      textColor: Theme.of(context).colorScheme.onBackground,
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      horizontalMargin: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 10),
                      onClick: () {})
                ],
              ),
              BigTextButton(
                  text: 'This is the button',
                  fontWight: FontWeight.bold,
                  cornerRadius: 16,
                  elevation: 0,
                  backgroudColor: Theme.of(context).scaffoldBackgroundColor,
                  borderColor: Theme.of(context).cardColor,
                  textColor: Theme.of(context).hintColor,
                  padding: const EdgeInsets.only(top: 17, bottom: 17),
                  horizontalMargin:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                  onClick: () {})
            ],
          ),
        ));
  }

  Widget _appBar() {
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
                'This is title',
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
