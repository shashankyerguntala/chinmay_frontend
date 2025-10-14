class ApiConstants {
  static const String baseUrl = "https://gifted-hisako-nearly.ngrok-free.dev";
  //!CHINMAY

  //! AUTH
  static const String register = "/api/users/signup";
  static const String login = "/api/auth/login";

  //! HOME
  static const String getAllPosts = "/api/posts/feed";

  static String userPosts(String id) => "/api/users/$id/posts";
  static String userApprovedPosts(int id) =>
      '/api/posts/user/$id/status/Approved';
  static String userDeclinededPosts(int id) =>
      '/api/posts/user/$id/status/disapproved';
  static String userPendingPosts(int id) =>
      '/api/posts/user/$id/status/pending';
  static String userProfile = '/api/users/profile'; //
  static String becomeModerator = '/api/users/moderator-request'; //

  //! Posts
  static const String createPost = "/api/posts"; //

  static String updatePost(int id) => "/api/posts/$id"; //
  static String deletePost(int id) => "/api/posts/$id"; //

  //! Comments
  static String sendComment(int postId) => "/api/posts/$postId/comment"; //

  //! Moderator
  static String getModeratorPendingComments =
      "/api/moderator/comments/pending"; //
  static String getModeratorPendingPosts = '/api/moderator/posts/pending'; //
  static String approvePost(int postId) =>
      '/api/moderator/posts/$postId/approve'; //
  static String rejectPost(int postId) =>
      '/api/moderator/posts/$postId/deny'; //
  static String approveComment(int postId) =>
      '/moderator/comments/$postId/approve';
  static String rejectComment(int postId) =>
      '/moderator/comments/$postId/deny'; //

  //! Admin
  static String approveModerator(int reqId) =>
      "/api/moderator-requests/$reqId/review";
  static String rejectModerator(int reqId) =>
      "/api/moderator-requests/$reqId/review";
  static String getModeratorRequests = "/api/admin/moderators";//

  //! superadmin

  static String getAdminRequests = "/api/admin-requests";
  static String approveAdmin(int reqId) => "/api/admin-requests/$reqId/review";
  static String rejectAdmin(int reqId) => "/api/admin-requests/$reqId/review";

  //! flag a post
  static String flagPost(int postId) => '/api/moderation/posts/$postId';
}
