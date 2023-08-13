class Urls{
  Urls._();

  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTask = '$_baseUrl/listTaskByStatus/New';
  static String inProgressTask = '$_baseUrl/listTaskByStatus/Progress';
  static String cancelledTasks = '$_baseUrl/listTaskByStatus/Canceled';
  static String completedTasks = '$_baseUrl/listTaskByStatus/Completed';
  static String deleteTasks(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTasks(String id,String status) => '$_baseUrl/updateTaskStatus/$id/$status';
  static String profileUpdate = '$_baseUrl/profileUpdate';
  static String sendOTPToEmail(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerification (String email, String otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String recoverResetPass = '$_baseUrl/RecoverResetPass';
}