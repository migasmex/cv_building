enum CvListType{
  cvRequestList,
  basicCvList,
}

class GetCvRequestListPayload {
  final String userId;
  final CvListType cvListType;

  GetCvRequestListPayload({
    required this.cvListType,
    required this.userId,
  });
}
