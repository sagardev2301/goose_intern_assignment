import 'package:flutter/material.dart';


class PhotosPickButton extends StatelessWidget {
  const PhotosPickButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.add_box_rounded,
              size: 25,
              color: Colors.grey[400],
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              'Add photos',
              style: TextStyle(
                  fontSize: 15, color: Colors.grey[500]),
            )
          ],
        ),
      ),
    );
  }
}