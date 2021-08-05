String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'sign_in_required':
      return 'Something went wrong with sign in attempt';
      break;
    case 'network-request-failed':
      return 'Something went wrong with your network connectivity';
      break;
    case 'network_error':
      return 'Something went wrong with your network connectivity';
      break;
    case 'invalid_account':
      return 'Your google account is invalid';
      break;
    case 'internal_error':
      return 'Something went wrong with sign in attempt';
      break;
    case 'invalid-email':
      return 'That email is not correct';
      break;
    case 'user-not-found':
      return 'The user was not found';
      break;
    case 'unknown':
      return 'The fields cannot be empty';
      break;
    case 'invalid-password':
      return 'The password is too short';
      break;
    case 'wrong-password':
      return 'Current password is wrong';
      break;
    case 'email-already-in-use':
      return 'This email already exists';
      break;
    case 'too-many-requests':
      return 'You have to wait a moment to next login attempt';
    case 'sign-in-google-went-wrong':
      return 'Something went wrong with sign in attempt';
      break;
    default:
      return 'Something went wrong';
      break;
  }
}
