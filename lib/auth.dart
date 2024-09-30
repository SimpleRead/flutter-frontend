class AuthToken {
  String _user = "";
  String _pass = "";
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
}
