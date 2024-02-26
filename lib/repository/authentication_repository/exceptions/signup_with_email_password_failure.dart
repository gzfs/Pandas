class SignUpWithEmailPasswordFailure {
  final String message;

  const SignUpWithEmailPasswordFailure(
      {this.message = "Unknown Error Occured"});

  factory SignUpWithEmailPasswordFailure.code(String? errCode) {
    switch (errCode) {
      case 'weak-password':
        return const SignUpWithEmailPasswordFailure(
            message: "Please enter a Stronger Password");
      case 'invalid-email':
        return const SignUpWithEmailPasswordFailure(
            message: "Email is not Valid or Badly Formatted");
      case 'email-already-in-use':
        return const SignUpWithEmailPasswordFailure(
            message: "An Account already exists for this Email");
      case 'operation-not-allowed':
        return const SignUpWithEmailPasswordFailure(
            message: "No Bitches for You!!");
      case 'user_disabled':
        return const SignUpWithEmailPasswordFailure(
            message: "This User has been Disabled due to their Horniness");
      default:
        return const SignUpWithEmailPasswordFailure();
    }
  }
}
