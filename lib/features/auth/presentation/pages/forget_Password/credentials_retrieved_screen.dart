import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/core/theme/app_colors.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';

class CredentialsRetrievedScreen extends StatefulWidget {
  final CredentialResponse credentials;

  const CredentialsRetrievedScreen({super.key, required this.credentials});

  @override
  State<CredentialsRetrievedScreen> createState() =>
      _CredentialsRetrievedScreenState();
}

class _CredentialsRetrievedScreenState
    extends State<CredentialsRetrievedScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceContainer,
      appBar: AppBar(
        title: const Text('Credentials'),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const Spacer(flex: 1),
              _buildSuccessIndicator(),
              const SizedBox(height: 32),
              _buildCredentialsCard(),
              const SizedBox(height: 40),
              _buildActionButtons(context),
              const Spacer(flex: 2),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIndicator() {
    final creds = widget.credentials;
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            color: AppColors.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        ),
        const SizedBox(height: 24),
        const Text(
          'Credentials Retrieved! 🎉',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: AppColors.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        if (creds.studentName != null) ...[
          const SizedBox(height: 8),
          Text(
            creds.studentName!,
            style: const TextStyle(
              color: AppColors.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 12),
        const Text(
          'Save these details and log in to get started.',
          style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildCredentialsCard() {
    final creds = widget.credentials;
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F1E1B15),
            blurRadius: 48,
            offset: Offset(0, 24),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildCredentialRow(
            label: 'STUDENT ID',
            value: creds.studentId,
            onCopy: () => _copyToClipboard(context, creds.studentId),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(color: AppColors.surfaceContainerHighest, height: 1),
          ),
          _buildCredentialRow(
            label: 'USERNAME (EMAIL)',
            value: creds.username,
            onCopy: () => _copyToClipboard(context, creds.username),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(color: AppColors.surfaceContainerHighest, height: 1),
          ),
          _buildCredentialRow(
            label: 'PASSWORD',
            value: _obscurePassword ? '••••••••' : creds.password,
            onCopy: () => _copyToClipboard(context, creds.password),
            isPassword: true,
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            obscurePassword: _obscurePassword,
          ),
        ],
      ),
    );
  }

  Widget _buildCredentialRow({
    required String label,
    required String value,
    required VoidCallback onCopy,
    bool isPassword = false,
    VoidCallback? onToggleVisibility,
    bool obscurePassword = true,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurface,
                  letterSpacing: isPassword && obscurePassword ? 4.0 : null,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isPassword)
              IconButton(
                onPressed: onToggleVisibility,
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.secondary,
                ),
              ),
            IconButton(
              onPressed: onCopy,
              icon: const Icon(Icons.content_copy, color: AppColors.secondary),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => context.go(AppRouteNames.login),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              backgroundColor: AppColors.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadowColor: AppColors.primaryContainer.withOpacity(0.2),
              elevation: 8,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Go to Login',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: AppColors.onPrimary, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () {
            if (context.canPop()) context.pop();
          },
          icon: const Icon(
            Icons.chevron_left,
            color: AppColors.onSurfaceVariant,
            size: 20,
          ),
          label: const Text(
            'Go back',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: AppColors.primary),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Text(
        'ACADEMIC PORTAL SECURE ACCESS',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          color: Colors.grey,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
