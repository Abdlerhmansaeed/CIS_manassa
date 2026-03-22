import 'package:equatable/equatable.dart';

class CredentialResponse extends Equatable {
  final String? studentName;
  final String studentId;
  final String username;
  final String password;

  const CredentialResponse({
    this.studentName,
    required this.studentId,
    required this.username,
    required this.password,
  });

  /// Parses credentials from the raw HTML returned by the CIS services portal.
  ///
  /// Successful HTML structure:
  ///   <span class="content"><code class="code">c2303024@cis.edu.eg</code></span>
  ///   <span class="content"><code class="code">Vus00893</code></span>
  ///
  /// Error HTML contains an alert() script call.
  factory CredentialResponse.fromHtml(String html) {
    // The specific error alert from the CIS portal when credentials are wrong.
    // We do NOT match generic alert() because the success page also has alert("تم النسخ").
    final hasErrorAlert = html.contains('برجاء ادخال الرقم القومي');
    if (hasErrorAlert) {
      throw const FormatException('invalid_credentials');
    }

    // Extract values from <code class="code">...</code> inside .content spans
    final codePattern = RegExp(
      r"""class=["']code["'][^>]*>\s*(.*?)\s*</code>""",
      caseSensitive: false,
      dotAll: true,
    );
    final codeMatches = codePattern
        .allMatches(html)
        .map((m) => m.group(1)?.trim() ?? '')
        .where((v) => v.isNotEmpty)
        .toList();

    if (codeMatches.length < 2) {
      throw const FormatException('no_data_found');
    }

    // Extract student ID from <strong> near "كود الطالب"
    final studentIdPattern = RegExp(
      r'كود الطالب\s*:.*?<strong>\s*(.*?)\s*</strong>',
      caseSensitive: false,
      dotAll: true,
    );
    final studentIdMatch = studentIdPattern.firstMatch(html);
    final studentId = studentIdMatch?.group(1)?.trim() ?? codeMatches[0];

    // Extract student name from <strong> near "اسم الطالب"
    final namePattern = RegExp(
      r'اسم الطالب\s*:.*?<strong>\s*(.*?)\s*</strong>',
      caseSensitive: false,
      dotAll: true,
    );
    final nameMatch = namePattern.firstMatch(html);
    final studentName = nameMatch?.group(1)?.trim();

    return CredentialResponse(
      studentName: studentName,
      studentId: studentId,
      username: codeMatches[0], // e.g. c2303024@cis.edu.eg
      password: codeMatches[1], // e.g. Vus00893
    );
  }

  @override
  List<Object?> get props => [studentName, studentId, username, password];
}
