import 'package:hive/hive.dart';
import 'package:software_engineering/models/result.dart';

class ResultAdapter extends TypeAdapter<Result> {
  @override
  final int typeId = 1; // Unique type id for the adapter

  @override
  Result read(BinaryReader reader) {
    final quizName = reader.readString(); // Read quizName property
    final score = reader.readInt(); // Read score property
    return Result(quizName: quizName, score: score);
  }


  @override
  void write(BinaryWriter writer, Result obj) {
    // Implement logic to write Result object to binary
    // This method is responsible for writing the object's properties to the writer
    // Example:
    writer.writeString(obj.quizName); // Write quizName property
    writer.writeInt(obj.score); // Write score property
  }
}