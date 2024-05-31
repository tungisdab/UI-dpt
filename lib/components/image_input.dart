import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web/styles/web_colors.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buttonUploadImage(),
            const SizedBox(width: 20,),
            buttonRecognition(),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Image Input:',
              style: TextStyle(color: WebColor.text, fontSize: 30),
            ),
            imageField(),
          ],
        )
      ],
    );
  }

  Widget buttonUploadImage() => ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(WebColor.buttonColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          fixedSize: MaterialStateProperty.all(
              Size(170, 50)), // Đặt kích thước cố định
          elevation: MaterialStateProperty.all(5), // Độ cao của nút
          shadowColor: MaterialStateProperty.all(Colors.grey), // Màu bóng đổ
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bo tròn góc nút
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.2); // Màu khi nhấn
              }
              return null; // Sử dụng màu mặc định cho các trạng thái khác
            },
          ),
        ),
        onPressed: () {
          _pickImage();
        },
        label: Text(
          'Upload Image',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: const Icon(
          Icons.upload,
          color: Colors.red,
        ),
      );

  Widget buttonRecognition() => ElevatedButton.icon(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(WebColor.buttonColor),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
          fixedSize: MaterialStateProperty.all(
              Size(170, 50)), // Đặt kích thước cố định
          elevation: MaterialStateProperty.all(5), // Độ cao của nút
          shadowColor: MaterialStateProperty.all(Colors.grey), // Màu bóng đổ
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Bo tròn góc nút
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red.withOpacity(0.2); // Màu khi nhấn
              }
              return null; // Sử dụng màu mặc định cho các trạng thái khác
            },
          ),
        ),
        onPressed: () async {
          await uploadImage();
        },
        label: Text(
          'Recognition',
          style: TextStyle(color: WebColor.textColor),
        ),
        icon: Image.asset(
          'assets/icons/video.png',
          fit: BoxFit.cover,
          height: 25,
          width: 25,
        ),
      );

  Widget imageField() => Container(
          child: DottedBorder(
        color: WebColor.textColor,
        dashPattern: [8, 4],
        strokeWidth: 2,
        child: Container(
            height: 400,
            width: 500,
            child: _pickedImage == null
                ? GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            scale: 3,
                            'assets/icons/photo.png',
                            // fit: BoxFit.contain,
                          ),
                          Text(
                            'Choose an image',
                            style: TextStyle(
                                color: WebColor.textColor, fontSize: 40),
                          )
                        ],
                      ),
                    ),
                  )
                : kIsWeb
                    ? Image.memory(
                        webImage,
                        fit: BoxFit.contain,
                      )
                    : Image.file(
                        _pickedImage!,
                        fit: BoxFit.contain,
                      )),
      ));

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selectedImage = File(image.path);
        setState(() {
          _pickedImage = selectedImage;
        });
      } else {
        log('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File('a');
        });
      } else {
        log('No image has been picked');
      }
    } else {
      log('Something went wrong');
    }
  }

  Future<void> uploadImage() async {
    if (_pickedImage == null && webImage == null) return;

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:5000/process-image'),
    );

    if (kIsWeb) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        webImage!,
        filename: 'upload.png', // Tên file khi upload
        contentType: MediaType('image', 'png'),
      ));
    } else {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _pickedImage!.path,
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final result = jsonDecode(responseData);

      print('Result khanh dep trai hehehe: ${result['result']}');
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }
}
