import 'package:eko_messenger/database/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/providers/database.g.dart';

@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();

  ref.onDispose(() async {
      await db.close();
  });

  return db;
}
