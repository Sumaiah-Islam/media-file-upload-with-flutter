import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'image_upload_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  ImagePickerCubit() : super(ImageInitial());

  List<XFile> get images => _images;

  Future<void> pickMultipleImages() async {
    emit(ImageLoading());
    try {
      final List<XFile>? pickedImages = await _picker.pickMultiImage();
      if (pickedImages != null) {
        _images.addAll(pickedImages);
        emit(ImageLoaded());
      } else {
        emit(ImageError(message: "No images selected"));
      }
    } catch (e) {
      emit(ImageError(message: "Failed to pick images: $e"));
    }
  }

  Future<void> captureImageWithCamera() async {
    emit(ImageLoading());
    try {
      final XFile? capturedImage = await _picker.pickImage(source: ImageSource.camera);
      if (capturedImage != null) {
        _images.add(capturedImage);
        emit(ImageLoaded());
      } else {
        emit(ImageError(message: "No image captured"));
      }
    } catch (e) {
      emit(ImageError(message: "Failed to capture image: $e"));
    }
  }

  void removeImage(int index) {
    _images.removeAt(index);
    emit(ImageLoaded());
  }
}
