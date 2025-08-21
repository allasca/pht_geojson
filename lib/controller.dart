import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/widgets.dart';

var textJson = ValueNotifier('{}');
var isLoading = ValueNotifier(false);
var namaFileBaru = TextEditingController(text: "Petak");

openFile() async {
  isLoading.value = true;
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['json'],
    allowMultiple: false,
    withData: true,
  );

  if (result != null) {
    Uint8List? bytes = result.files.first.bytes;
    textJson.value = String.fromCharCodes(bytes!);
  } else {}
  isLoading.value = false;
}

simpanFile() async {
  isLoading.value = true;
  await FileSaver.instance.saveFile(
    name: namaFileBaru.text,
    bytes: utf8.encode(textJson.value),
    fileExtension: "json",
    mimeType: MimeType.json,
  );
  isLoading.value = false;
}

hapusNullDanZero() {
  isLoading.value = true;
  Map json = textJson.value.isNotEmpty ? jsonDecode(textJson.value) : {};
  String jsonString = jsonEncode(json);
  String cleanedJson = jsonString.replaceAll(",0,null", "");
  textJson.value = cleanedJson;
  isLoading.value = false;
}
