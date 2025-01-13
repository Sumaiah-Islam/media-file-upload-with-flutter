abstract class ImagePickerState {}

class ImageInitial extends ImagePickerState {}

class ImageLoading extends ImagePickerState {}

class ImageLoaded extends ImagePickerState {}

class ImageError extends ImagePickerState {
  final String message;

  ImageError({required this.message});
}
