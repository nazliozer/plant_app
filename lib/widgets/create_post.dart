import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  File? _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>(); // Define form key
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _askToCommunityController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 100, 50, 50),
          child: Container(
            decoration: BoxDecoration(
                border: Border.symmetric(),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 201, 224, 109),
                    Color.fromARGB(255, 218, 242, 168)
                  ],
                  stops: [0.25, 0.75],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(220, 226, 201, 0.498),
                    spreadRadius: 10,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ]),
            width: 380, // Adjust width as needed
            height: 400, // Adjust height as needed

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "What is your question?",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Color.fromRGBO(108, 124, 117, 0.857),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      child: TextFormField(
                        controller: _askToCommunityController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              _askToCommunityController.clear();
                            },
                          ),
                          hintText: 'Ask to Community!',
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(108, 124, 117, 0.854)),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(
                                color: Colors.white, style: BorderStyle.none),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your question';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 4),
                        child: Text(
                          "Description",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(108, 124, 117, 0.857),
                          ),
                        ),
                      ),
                    ), // Adjust spacing between text fields
                    SizedBox(
                      width: 240, // <-- TextField width
                      height: 120, // <-- TextField height
                      child: TextFormField(
                        controller: _descriptionController,
                        maxLines: null,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide(style: BorderStyle.none),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              // Clear text field when clear button is pressed
                              _descriptionController.clear();
                            },
                          ),
                          hintText: 'Give More Detail!',
                          hintStyle: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(108, 124, 117, 0.854)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your description';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ), // Adjust spacing between text fields and camera icon
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40.0, right: 40, top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: 40,
                        height: 50,
                        // alignment: Alignment.center,
                        child: TextButton.icon(
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: () {
                            _selectImage(context);
                          },
                          label: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                Text("Add your photo!",
                                    style: GoogleFonts.poppins()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(253, 220, 34, 0.704)),
                          ),
                          onPressed: () {
                            // Clear form fields functionality
                            _descriptionController.clear();
                            _askToCommunityController.clear();
                          },
                          label: Text(
                            'Clear',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                        ElevatedButton.icon(
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromRGBO(253, 220, 34, 0.704)),
                          ),
                          onPressed: () {
                            // Submit form functionality
                            if (_formKey.currentState!.validate()) {
                              // Do something with the form data
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Your Question is Submitted!'),
                                ),
                              );
                            }
                          },
                          label: Text(
                            'Submit',
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to select image
  void _selectImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No image selected from gallery.'),
          ),
        );
      }
    });
  }
}
