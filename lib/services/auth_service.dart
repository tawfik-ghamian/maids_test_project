class AuthService {
  Future<bool> login({required String email, required String password}) async {
    // Simulate a login request to the server
    await Future.delayed(const Duration(seconds: 2)); // Simulating network delay
    if (email == 'example@example.com' && password == 'password') {
      return true; // Login successful
    } else {
      return false; // Login failed
    }
  }
}
