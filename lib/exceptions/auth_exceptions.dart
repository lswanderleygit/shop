class AuthException implements Exception {
  static const Map<String, String> errors = {
    "EMAIL_NOT_FOUND": "E-mail não encontrado!",
    "INVALID_PASSWORD": "Senha inválida!",
    "USER_DISABLED": "A conta do usuário foi desativada por um administrador.",
    "EMAIL_EXISTS": "O endereço de email já está sendo usado por outra conta.",
    "OPERATION_NOT_ALLOWED": "Operação não permitida!",
    "TOO_MANY_ATTEMPTS_TRY_LATER": "Tente mais tarde!",
  };

  final String key;

  const AuthException(this.key);

  @override
  String toString() {
    if (errors.containsKey(key)) {
      return errors[key];
    } else {
      return "Ocorreu um erro na autenticação!";
    }
  }
}
