import 'package:flutter/material.dart';

class AppAlert {
  show(
      {required BuildContext context,
      required String title,
      required String body,
      required String yes,
      required String no,
      required Function onYes,
      required Function onNo}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(primarySwatch: Colors.grey),
          child: AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            content: Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    onYes();
                  },
                  child: Text(
                    yes,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary),
                  )),
              TextButton(
                  onPressed: () {
                    onNo();
                  },
                  child: Text(
                    no,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
                  )),
            ],
          ),
        );
      },
    );
  }
}
