import '../models/cv_model.dart';

class AddCvForRequestPayload {
  final CvModel cvModel;
  final String userId;

  AddCvForRequestPayload({
    required this.cvModel,
    required this.userId,
  });
}
