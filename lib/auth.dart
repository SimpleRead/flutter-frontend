import 'package:http/http.dart' as http;
import 'package:simpleread/api.dart';
import 'dart:convert';

class AuthToken {
  String _user = "";
  String _pass = "";
  static final String _endpoint = "http://localhost:8000";
  AuthToken(String user, String pass) {
    this._user = user;
    this._pass = pass;
  }

  // TODO: Actual validation
  // Returns true if this user has been properly authenticated and can now use
  // the simpleread service.
  bool isValid() {
    return _user == "nate";
  }

  // If this auth token isn't valid, provide a human-readable justification as
  // to why.
  String getError() {
    if (this.isValid()) {
      return "Login was successful";
    }
    return "Invalid username/password";
  }

  @override
  String toString() {
    return this._user + ":" + this._pass;
  }

  Future<Homepage> homePage() async {
    final uri = Uri.parse('${_endpoint}/user/${_user}/home.json');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      return Future.error('Fetching homepage returned code ${response.statusCode}');
    }
    try {
      final responseMap = jsonDecode(response.body) as Map<String, dynamic>;
      return Homepage.fromJson(responseMap);
    } catch (e) {
      return Future.error('Failed parse home page: ${e}');
    }
  }
}
