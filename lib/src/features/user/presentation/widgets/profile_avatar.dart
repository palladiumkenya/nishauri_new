import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nishauri/src/local_file/file_system_storage.dart';
import 'package:nishauri/src/shared/input/ImagePicker.dart';
import 'package:nishauri/src/utils/helpers.dart';

class ProfileAvatar extends HookConsumerWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = useState<String?>(null);
    final size = getOrientationAwareScreenSize(context);

    useEffect(() {
      loadImage("images/avatar.jpg").then((value) {
        log("|Loaded********************$value*********************|");
        image.value = value?.path;
      });
    }, []);

    return ImagePickerCustom(
      size: size.width * 0.40,
      image: image.value,
      onImageChange: (image_) {
        // image.value = image_;
        final file = File.fromUri(Uri.parse(image_));
        saveImageLocally(file, "images/avatar.jpg").then((value) {
          log("***********$value******************");
          image.value = value;
        });
      },
      onDelete: () {
        // image.value = null;
        deleteFile("images/avatar.jpg").then((value) {
          log("*************Deleted: $value**********************");
          if(value) image.value = null;
        });
      },
    );
  }
}
