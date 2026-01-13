import 'package:ecp/ecp.dart';
import 'package:ecp/src/types/typedefs.dart';

class InMemoryCapabilitiesStore extends CapabilitiesStore {
  Map<String, dynamic>? _capabilites;
  DateTime? _timestamp;

  @override
  Future<CapabilitiesWithTime?> getCapabilities() async {
    if (_capabilites != null && _timestamp != null) {
      return (capabilites: _capabilites!, timestamp: _timestamp!);
    }
    return null;
  }

  @override
  Future<void> saveCapabilities(Map<String, dynamic> capabilities) async {
    _capabilites = capabilities;
    _timestamp = DateTime.now();
  }
}
