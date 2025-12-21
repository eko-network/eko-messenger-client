import 'package:eko_messanger/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}
