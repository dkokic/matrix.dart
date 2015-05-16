// The HTML import containing our <polymer-element>
@HtmlImport('app_login.html')
library matrix.webclient.component.login;

import 'package:polymer/polymer.dart';

export 'package:paper_elements/paper_button.dart';
export 'package:paper_elements/paper_input_decorator.dart';
export 'package:paper_elements/paper_radio_button.dart';
export 'package:paper_elements/paper_radio_group.dart';

@CustomTag('app-login')
class AppLogin extends PolymerElement {

  @observable
  var login_type = 'mxid';
  var login_type_label = {
    'email': 'Email address',
    'mxid': 'Matrix ID (e.g. @bob:matrix.org or bob)'
  };
  var account = new Account();

  String paramValue;

  /// The custom attribute.
  @PublishedProperty(reflect: true)
  String get param {
    String value = readValue(#param);
    print('getting param value $value');
    return value;
  }
  void set param(value) {
    print('setting param value to $value');
    if (value == 'two') {
      print('overriding two with four');
      writeValue(#param, 'four');
    } else {
      writeValue(#param, value);
    }
  }

  AppLogin.created() : super.created();

  domReady() {
    print('domReady(): paramValue = $paramValue');
  }

  login() {
    print('login(): account = $account');
  }

  String get feedback => '';
  String get login_error_msg => '';

}

class Account extends Observable {
  @observable
  String user_id = '';
  @observable
  String password = '';
  String homeServer = 'https://matrix.org';
  String identityServer = 'https://matrix.org';
  bool get readyToLogin => user_id.isNotEmpty && password.isNotEmpty && homeServer.isNotEmpty;
  String toString() => 'Account{user_id: $user_id, password: $password}';
}