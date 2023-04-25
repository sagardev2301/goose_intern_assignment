import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_avatar/random_avatar.dart';

class CustomAvatar extends StatefulWidget {
  const CustomAvatar({super.key});

  @override
  State<CustomAvatar> createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  late Widget svgCode = RandomAvatar( Random().toString(), height: 120, width: 120);

  Future<void> selectImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        svgCode = Container(
          height: 120,
          width: 120,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.file(
                File(pickedImage.path),
                fit: BoxFit.cover,
              )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return Stack(
      children: [
        svgCode,
        Positioned(
          bottom: 0,
          right: 10,
          child: GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    contentPadding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    backgroundColor: Colors.grey[800],
                    content: SizedBox(
                      height: 80,
                      width: 50,
                      child: Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectImage(source: ImageSource.camera);
                                navigator.pop();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.camera,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Camera',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectImage(source: ImageSource.gallery);
                                navigator.pop();
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.image,
                                    size: 30,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Gallery',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  );
                },
              );
            },
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor,
              ),
              child: const Icon(FontAwesomeIcons.pen,
                  color: Colors.white, size: 16),
            ),
          ),
        )
      ],
    );
  }
}
