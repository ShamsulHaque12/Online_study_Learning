class ApiEndpoints {
  static const String baseUrl = 'http://206.162.244.131:5002';
  static const String _baseUrl = 'http://206.162.244.131:5002/api/v1';
  static const String createAccount = '$_baseUrl/auth/create-account';
  static const String verifySignupOTP = '$_baseUrl/auth/verify-signup-otp';
  static const String login = '$_baseUrl/auth/login';
  static const String forgotPassword = '$_baseUrl/auth/forgot-password';
  static const String verifyEmail = '$_baseUrl/auth/verify-reset-password-otp';
  static const String resendOTP = '$_baseUrl/auth/resend-otp';
  static const String resetPassword = '$_baseUrl/auth/reset-password';

  //--------------- User Endpoints -------------------//
  static const String getUser = '$_baseUrl/users/me';
  static const String updateProfile = '$_baseUrl/users/update-profile';
  static const String updateProgress = '$_baseUrl/progress';
  static const String getProgress = '$_baseUrl/progress/my-progress';

  //------------------- AI Endpoints -------------------//
  static const String aiBaseUrl = 'http://206.162.244.134:8054';
  static const String genaretStory = '$aiBaseUrl/story/generate-story';
  static const String dialougeBuilder = '$aiBaseUrl/dialogue/generate-dialogue';
  static const String rolePlaySimulation =
      '$aiBaseUrl/roleplay/generate-scenario';
  static const String aiGeneratePrompt = '$aiBaseUrl/writing/generate-prompt';
  static const String aiEvaluateWriting = '$aiBaseUrl/writing/evaluate';
  static const String dialougeLisenting =
      '$aiBaseUrl/listening/generate-practice';
  static const  String textToSpeech = '$aiBaseUrl/listening/audio/';
  static const String dictionary = '$_baseUrl/ai-practice/search';
  static const String camera = '$_baseUrl/ai-practice/detect-image';
  static const String roleSimulationEvaluation =
      '$aiBaseUrl/roleplay/generate-scenario';
  static const String roleCorrection =
      '$aiBaseUrl/roleplay/evaluate-response';
  static const String aiRolePlayAudio = '$aiBaseUrl/conversation/start';
  static const String aiRolePlayResponse = '$aiBaseUrl/conversation/reply';
  static const String specToText = '$aiBaseUrl/transcribe';
  static const String generateFlashCards = '$aiBaseUrl/flashcards/generate';

  //--------------- Save Bookmark -------------------//
  static const String savePost = '$_baseUrl/dictionary/add';
  static const String getSavePost = '$_baseUrl/dictionary/all';

  //--------------- Lesson Endpoints -------------------//
  static const String lessonTitle = '$_baseUrl/lessons/topics';
  static const String lessonPart1 = '$_baseUrl/lessons/topics/';
  static const String chapterPercent = '$_baseUrl/lessons/chapter-percentage?chapter=';

  //--------------- Progress Endpoints -------------------//
  static const String pointSummary = '$_baseUrl/dashboard/points/summary';
  static const String dailyPoint = '$_baseUrl/dashboard/points/daily';
  static const String pointHistory = '$_baseUrl/dashboard/points/history';
  static const String steckerPack = '$_baseUrl/dashboard/streak';
  static const String lederBoard = '$_baseUrl/dashboard/leaderboard';
  static const String mastryLevel = '$_baseUrl/dashboard/mastery';
  static const String achivement = '$_baseUrl/dashboard/achievements';

  ///............ Foller Endpoints ...............//
  static const String follower = '$_baseUrl/followers';
  static const String following = '$_baseUrl/followers/following';
  static const String unfollow = '$_baseUrl/followers/unfollow';
  static const String searchBox = '$_baseUrl/followers/search?query=';
  static const String findFriends = '$_baseUrl/followers/profile/';
  static const String followUser = '$_baseUrl/followers/follow';
}
