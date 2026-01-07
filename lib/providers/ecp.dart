import 'package:eko_messanger/providers/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecp/ecp.dart';

part '../generated/providers/ecp.g.dart';

@Riverpod(keepAlive: true)
EcpClient? ecp(Ref ref) {
  final auth = ref.watch(authProvider);
  final authInfo = auth.info;

  if (authInfo == null) {
    return null;
  }

  return EcpClient(
    storage: auth.ecpStorage,
    client: auth.client,
    me: authInfo.actor,
    did: authInfo.did,
    tokenGetter: auth.token,
  );
}
