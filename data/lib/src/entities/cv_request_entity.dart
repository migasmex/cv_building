class CvRequestEntity {
  final List<String> cvIdList;
  final String userId;

  CvRequestEntity({
    required this.cvIdList,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cvIdList': cvIdList,
      'userId': userId,
    };
  }

  factory CvRequestEntity.fromMap(Map<String, dynamic> map) {
    return CvRequestEntity(
      cvIdList: List<String>.from(map['cvIdList'] ?? <String>[]),
      userId: map['userId'],
    );
  }
}
