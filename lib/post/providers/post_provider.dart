import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';


class Post extends ChangeNotifier {
  final user = FirebaseAuth.instance.currentUser;

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> postUpload(
      {required String title,
      required String category,
      String? description,
      required double price,
      List<XFile>? images}) async {
    try {
      List<String> imageUrls = [];

      DocumentReference postDocRef =
          FirebaseFirestore.instance.collection('posts').doc();

      if (images!.isNotEmpty) {
        for (var i = 0; i < images.length; i++) {
          XFile image = images[i];

          // Create a reference to the location where the image will be stored in Firebase Storage
          var ref = FirebaseStorage.instance
              .ref()
              .child('users')
              .child(user!.uid)
              .child(postDocRef.id)
              .child('/${images[i].name}');

          // Upload the image to Firebase Storage
          TaskSnapshot taskSnapshot = await ref.putFile(File(image.path));

          // Get the download URL of the image
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();

          // Add the download URL to the list of image URLs
          imageUrls.add(downloadUrl);
        }
      }
      // Upload the post Details to the location where the post details will be stored in Firebase Firestore
      await postDocRef.set({
        'title': title,
        'category': category,
        'description': description,
        'price': price,
        'createdAt': DateTime.now(),
        'imagesUrl': imageUrls,
      });

      // Get the reference 
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user!.uid);
      await userRef.update({
        'postsId': FieldValue.arrayUnion([postDocRef.id]),
      });
    } on Exception catch (_) {
      rethrow;
    }
  }
}
