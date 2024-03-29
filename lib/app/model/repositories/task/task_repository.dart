abstract class TaskSource {
  Future<void> save({required DateTime date, required String description});
  Future<void> update(Map<String, dynamic> data);
  Future<void> delete(String uuid);
  Future<void> clearAll();
  Future<List<TaskModel>> readAll();
  Future<List<TaskModel>> findByPeriod(
      {required DateTime start, DateTime? end});
  Future<void> checkOrUncheckTask(TaskModel task);
}
