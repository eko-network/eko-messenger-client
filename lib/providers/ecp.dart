import 'package:eko_messenger/providers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecp/ecp.dart';

part '../generated/providers/ecp.g.dart';

@Riverpod(keepAlive: true)
EcpClient ecp(Ref ref) {
  final auth = ref.watch(authProvider);
  final client = auth.ecpClient;

  // If no client is available, throw an error
  if (client == null) {
    throw StateError("EcpClient used before authentication or after logout");
  }

  return client;
}
