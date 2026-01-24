import 'package:eko_messenger/providers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecp/ecp.dart';

part '../generated/providers/ecp.g.dart';

@Riverpod(keepAlive: true)
EcpClient ecp(Ref ref) {
  final auth = ref.watch(authProvider);
  assert(auth.ecpClient != null, "EcpClient used before authentication");
  return auth.ecpClient!;
}
