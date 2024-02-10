import 'package:commits_history/api/extensions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' show Response, get;

import '../../manager/app_state_manager.dart';

class AuthServices {
  final String _baseUrl = dotenv.env['GITHUB_API_URL'] ?? '';
  String? _authToken;

  late Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'token ${_authToken ?? ''}'
  };

  Future init() async {
    // Not read the token if is already saved in the instance.
    if (_authToken != null) {
      return;
    } else {
      _authToken = await AppStateManager.storage.read(key: 'token');

      if (_authToken == null) {
        return 'Can not init, because the user is not authenticated';
      }
    }
  }

  Future<Response> login({required String token, required bool viewThisRepo}) async {
    final response = await get(
      Uri.parse("$_baseUrl/octocat"),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'token $token'
      }
    );

    // Save the token to use in future calls to the API in case the user
    //  was successfully logged in
    if (response.isSuccessful) {
      await AppStateManager.storage.write(key: "token", value: token);

      // If the user wants to see the commits of the repo
      if (viewThisRepo) {
        await getHistoryCommits(repoName: dotenv.env['REPO_NAME'], repoOwner: dotenv.env['REPO_OWNER']);
      }
    }

    return response;
  }

  Future<Response> getUserProjects() async {
    await init();

    final response = await get(
      Uri.parse("$_baseUrl/user/repos"),
      headers: headers,
    );

    return response;
  }

  Future<Response> getHistoryCommits({required repoName, required repoOwner}) async {
    await init();

    final response = await get(
        Uri.parse("$_baseUrl/repos/$repoOwner/$repoName/commits"),
        headers: headers,
    );

    // Save the token to use in future calls to the API in case the user
    //  was successfully logged in
    if (response.isSuccessful) {
      // TODO: Use Models to save the commits
      // final List<dynamic> parsed = json.decode(response.body);
    }

    return response;
  }

// TODO: Make model to save the commits

}