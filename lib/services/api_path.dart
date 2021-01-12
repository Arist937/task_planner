class APIPath {
  static String job(String uid, String taskId) => 'users/$uid/tasks/$taskId';
  static String jobs(String uid) => 'users/$uid/tasks';
}
