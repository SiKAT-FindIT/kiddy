import 'package:equatable/equatable.dart';

class DetectionModel extends Equatable {
  final double confidence;
  final int index;
  final String label;

  const DetectionModel({
    required this.confidence,
    required this.index,
    required this.label,
  });

  factory DetectionModel.fromJson(Map<String, dynamic> json) {
    return DetectionModel(
      index: json['index'].toInt(),
      confidence: json['confidence'].toDouble(),
      label: json['label'].toString(),
    );
  }

  @override
  List<Object?> get props => [confidence, index, label];
}
