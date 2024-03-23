String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'sign_in_required':
      return 'Something went wrong with sign in attempt';
    case 'network-request-failed':
      return 'Something went wrong with your network connectivity';
    case 'network_error':
      return 'Something went wrong with your network connectivity';
    case 'invalid_account':
      return 'Your google account is invalid';
    case 'internal_error':
      return 'Something went wrong with sign in attempt';
    case 'invalid-email':
      return 'That email is not correct';
    case 'user-not-found':
      return 'The user was not found';
    case 'unknown':
      return 'The fields cannot be empty';
    case 'invalid-password':
      return 'The password is too short';
    case 'wrong-password':
      return 'Current password is wrong';
    case 'email-already-in-use':
      return 'This email already exists';
    case 'too-many-requests':
      return 'You have to wait a moment to next login attempt';
    case 'sign-in-google-went-wrong':
      return 'Something went wrong with sign in attempt';
    default:
      return 'Something went wrong';
  }
}
