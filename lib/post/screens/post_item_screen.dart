import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class PostItemScreen extends StatefulWidget {
  const PostItemScreen({super.key});
  static const routeName = '/post-item-screen';
  @override
  State<PostItemScreen> createState() => _PostItemScreenState();
}

class _PostItemScreenState extends State<PostItemScreen> {
  String? itemName, itemDescription, selectedItem;
  int? itemPrice;
  List<String> itemCategories = [
    "Electronics",
    "Vehicles",
    "Home and Furniture",
    "Fashion",
    "Real Estate",
    "Sports",
  ];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ImagePicker picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  Future<void> selectImages() async {
    List<XFile>? imagesSelected = await picker.pickMultiImage();
    setState(() {
      if (imagesSelected.isNotEmpty) {
        imagesFileList!.addAll(imagesSelected);
      }
    });
  }

  void _deleteImage(int index) {
    setState(() {
      imagesFileList!.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sell an item',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Herald Towers',
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
        leading: Icon(
          FontAwesomeIcons.boxOpen,
          size: 20,
          color: Theme.of(context).primaryColor,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: null,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        print(isKeyboardVisible);
        return Form(
          key: _formKey,
          child: Stack(children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white54, width: 1),
                          ),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fillColor: Colors.grey[800],
                          hintText: 'Item Name',
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          contentPadding: const EdgeInsets.only(left: 10),
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            itemName = newValue!;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Item name';
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Category*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      child: DropdownButtonFormField2(
                        value: selectedItem,
                        hint: Text(
                          'Select Item Cateogry',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white54, width: 1),
                          ),
                          contentPadding: const EdgeInsets.all(10),
                          isDense: true,
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fillColor: Colors.grey[800],
                        ),
                        validator: (value) {
                          if (value == null) {
                            return 'Please Select Item Category';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            selectedItem = value;
                          });
                        },
                        onSaved: (value) {
                          selectedItem = value.toString();
                        },
                        // buttonStyleData: const ButtonStyleData(
                        //   height: 30,
                        //   padding: EdgeInsets.only(left: , right: 10),
                        // ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          iconSize: 30,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          width: width * 0.92,
                          direction: DropdownDirection.left,
                          offset: const Offset(10, -15),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        items: itemCategories
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 120,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        keyboardType: TextInputType.text,
                        maxLines: 150,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white54, width: 1),
                          ),
                          constraints: const BoxConstraints(maxHeight: 150),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fillColor: Colors.grey[800],
                          hintText:
                              'Describe the condition of the item and terms of buying\n"Slightly used, almost new"\n"pickup on weekend only"',
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            itemDescription = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Price*",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        style: Theme.of(context).textTheme.titleSmall,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: Colors.white54, width: 1),
                          ),
                          filled: true,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.dollarSign,
                            size: 15,
                          ),
                          prefixIconColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          fillColor: Colors.grey[800],
                          hintText: '100',
                          hintStyle: Theme.of(context).textTheme.displaySmall,
                          contentPadding: const EdgeInsets.all(10),
                        ),
                        onSaved: (newValue) {
                          setState(() {
                            itemPrice = int.parse(newValue!);
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Item name';
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Photos",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children: imagesFileList!
                            .map((item) => Container(
                                  height: 100,
                                  width: width * 0.30,
                                  padding: const EdgeInsets.all(2),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Container(
                                          height: 95,
                                          width: width * 0.28,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              File(item.path),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Icon(
                                          FontAwesomeIcons.solidCircle,
                                          size: 24,
                                          fill: 1,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Positioned(
                                        right: -12,
                                        top: -12,
                                        child: IconButton(
                                          onPressed: () => _deleteImage(
                                              imagesFileList!.indexOf(item)),
                                          icon: Icon(
                                            FontAwesomeIcons.solidCircleXmark,
                                            size: 25,
                                            fill: 1,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      onTap: selectImages,
                      child: Container(
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
                      ),
                    ),
                    const SizedBox(
                      height: 90,
                    )
                  ],
                ),
              ),
            ),
            if (!isKeyboardVisible)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  color: Colors.grey[800],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              'Discard',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: width * 0.42,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              'Create Post',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ]),
        );
      }),
    );
  }
}
