import 'package:uuid/uuid.dart';

class UniqueIdGenerator {
  // for singleton
  static final UniqueIdGenerator _instance = UniqueIdGenerator._internal();
  factory UniqueIdGenerator() => _instance;
  UniqueIdGenerator._internal();

  final Uuid _uuid = const Uuid();

  String generateId() => _uuid.v1();
}
