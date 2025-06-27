import '../models/cv_model.dart';

class DeleteCvFromRequestPayload {
  final CvModel cvModel;
  final String userId;

  DeleteCvFromRequestPayload({
    required this.cvModel,
    required this.userId,
  });
}
