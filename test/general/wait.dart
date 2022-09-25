/// Wait so the id will be different,
/// Test is so fast that the id for different
/// widget which is milliseconds can be the same
/// In real app user can not create two widget at the same time
Future wait() {
  return Future.delayed(const Duration(milliseconds: 4));
}
