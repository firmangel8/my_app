Future<void> doLogout(context) async {
  debugPrint("need logout");
  final response = await DataService.logoutData();
  if (response.statusCode == 200) {
    await SecureStorageUtil.storage.delete(key: tokenStoreName);
    Navigator.pushReplacementNamed(context, "/login-screen");
  }
}

// di drawer pasang List Tile logout
ListTile(
  title: const Text('Logout'),
  onTap: () {
    doLogout(context);
  },
),

