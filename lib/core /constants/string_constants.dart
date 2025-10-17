class StringConstants {
  //!auth constants
  static const String appTitle = 'Postly App';
  static const String terms = 'Please agree to terms of use and privacy policy';
  static const String alreadyUser = 'Already a User?';
  static const String notUser = 'Not a user?';
  static const String welcomeBack = 'Welcome Back ! Sign In into your account';
  static String welcomeUser(String username) =>
      "Welcome back $username"; ///////////////
  static const String signUpTitle = 'Sign Up';
  static const String signInTitle = 'Sign In';
  static const String usernameLabel = 'Username';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String signUpButton = 'Sign Up';
  static const String createAccount = ' Please create a new account';

  static const String usernameEmpty = 'Enter a username';
  static const String usernameShort = "Username must be at least 4 characters";
  static const String emailEmpty = 'Enter an email';
  static const String emailInvalid = 'Enter a valid email';
  static const String passwordEmpty = 'Enter a password';
  static const String passwordShort = 'Password must be at least 6 characters';
  static const String passwordNotStrong =
      'Password must contain at least one uppercase letter\n one lowercase letter\n one digit, and one special character';

  static const String signUpSuccess = 'Sign Up Successful!';
  static const String signUpFailure = 'Sign Up Failed. Please try again.';

  static const String loginTitle = 'Login';

  static const String loginFailure = 'Login Failed. Please try again.';

  //! route constants

  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
  static const String create = '/create';
  static const String profile = '/profile';
  static const String admin = '/admin';
  static const String moderator = '/moderator';
  static const String superAdmin = '/superadmin';
  static const String addAdmin = '/addadmin';

  //! home screen constants
  static const String noPostsAvailable = "No posts available";
  static const String writeComment = "Write a comment ..";
  static const String inappropriatePost =
      "Do u think this post is INAPPROPRIATE";
  static const String flag = "Flag";
  static const String cancel = "Cancel";
  static const String flagAsSensitive = "Flag as Sensitive";

  //! profile screen constants

  static const String postDeleted = 'Post Deleted successfully';

  //! create post screen constants
  static const String titleEmptyError = "Post title can't be empty";
  static const String descEmptyError = "Post Description can't be empty";
  static const String errorWhileEditing = 'Error while editing the post !';
  static const String postEdited = 'Post Edited successfully';

  static const String postCreated = "Post created successfully";
  static const String createPost = "Create Post";
  static const String editPost = "Edit Post";
  static const String post = 'Post';
  static const String enterTitle = 'Enter a valid title';
  static const String enterDesc = 'Enter a valid description';
  static const String title = 'Title';
  static const String desc = 'Description';
  static const String edit = 'Edit';
}
