import 'package:http/http.dart' as http;

class HttpClientHelper extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Content-Type'] = 'application/json';
    request.headers['Accept'] = 'application/json';

    return _inner.send(request);
  }

  @override
  void close() {
    _inner.close();
  }
}
