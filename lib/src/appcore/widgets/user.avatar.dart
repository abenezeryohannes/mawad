import 'package:flutter/material.dart';

import '../utils/utils.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar(
      {Key? key,
      required this.size,
      required this.onUpload,
      required this.isLoading,
      required this.localImage})
      : super(key: key);
  final double size;
  final String? localImage;
  final Function(String) onUpload;
  final Function(bool) isLoading;
  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stack(
        children: [
          // TODO
          // widget.userDto.when(
          //     emptyState: () => Container(
          //           height: widget.size,
          //           width: widget.size,
          //           decoration: BoxDecoration(
          //               color: Colors.grey.shade300, shape: BoxShape.circle),
          //           child: Container(
          //             height: widget.size,
          //             width: widget.size,
          //             decoration: BoxDecoration(
          //                 color: Colors.grey.shade300, shape: BoxShape.circle),
          //           ),
          //         ),
          //     loadingState: (_) => Container(
          //           height: widget.size,
          //           width: widget.size,
          //           decoration: BoxDecoration(
          //               color: Colors.grey.shade300, shape: BoxShape.circle),
          //           child: CustomShimmer(
          //             show: true,
          //             child: Container(
          //               height: widget.size,
          //               width: widget.size,
          //               decoration: BoxDecoration(
          //                   color: Colors.grey.shade300,
          //                   shape: BoxShape.circle),
          //             ),
          //           ),
          //         ),
          //     loadedState: (value) => ImageForm(
          //           width: widget.size,
          //           height: widget.size,
          //           radius: 100,
          //           imageLink: (value as UserModel).avatar == null
          //               ? null
          //               : Api.getMedia(value.avatar!),
          //           localImage: widget.localImage,
          //           placeholder: Container(
          //             height: widget.size,
          //             width: widget.size,
          //             decoration: BoxDecoration(
          //                 border: Border.all(
          //                     width: 2,
          //                     color: Theme.of(context).colorScheme.secondary),
          //                 image: const DecorationImage(
          //                     image: AssetImage(
          //                         "assets/img/profile_placeholder.png")),
          //                 borderRadius:
          //                     const BorderRadius.all(Radius.circular(100))),
          //           ),
          //           onUpload: (x) {
          //             if (value.avatar == null) widget.onUpload(x);
          //           },
          //           isLoading: (loading) => widget.isLoading(loading),
          //         ),
          //     errorState: (failure) => SizedBox(
          //           height: widget.size,
          //           child: Column(
          //             mainAxisSize: MainAxisSize.min,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Image.asset("assets/img/profile_placeholder.png"),
          //               // Flexible(
          //               //     child: Text(
          //               //   failure.message ?? '',
          //               //   style: Theme.of(context)
          //               //       .textTheme
          //               //       .caption!
          //               //       .copyWith(color: Colors.red),
          //               // ))
          //             ],
          //           ),
          //         )),
          Align(
            alignment: const Alignment(1, 1),
            child: InkWell(
              onTap: () async {
                await Util.GetImage(context, widget.isLoading, widget.onUpload);
              },
              child: Container(
                width: 26,
                height: 26,
                margin: const EdgeInsets.only(right: 5, bottom: 5),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Theme.of(context).colorScheme.secondary),
                child: const Icon(
                  Icons.edit_note,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
