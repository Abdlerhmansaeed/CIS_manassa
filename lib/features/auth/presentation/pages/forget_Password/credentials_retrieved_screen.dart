import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mansaa_app/core/routing/app_route_names.dart';
import 'package:mansaa_app/features/auth/data/models/credential_response/credential_response.dart';
import 'package:mansaa_app/core/extensions/theme_extension.dart';
import 'package:mansaa_app/core/extensions/localization_extension.dart';

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
      backgroundColor: context.colors.surfaceContainer,
      appBar: AppBar(
        title: Text(context.l10n.credentials),
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.colors.primaryContainer),
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
          decoration: BoxDecoration(
            color: context.colors.surfaceContainerHighest,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.check_circle, color: Colors.green, size: 64),
        ),
        const SizedBox(height: 24),
        Text(
          context.l10n.credentialsRetrieved,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: context.colors.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        if (creds.studentName != null) ...[
          const SizedBox(height: 8),
          Text(
            creds.studentName!,
            style: TextStyle(
              color: context.colors.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        const SizedBox(height: 12),
        Text(
          context.l10n.credentialsRetrievedDescription,
          style: TextStyle(color: context.colors.onSurfaceVariant, fontSize: 14),
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
        color: context.colors.surfaceContainerLowest,
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
            label: context.l10n.studentId,
            value: creds.studentId,
            onCopy: () => _copyToClipboard(context, creds.studentId),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(color: context.colors.surfaceContainerHighest, height: 1),
          ),
          _buildCredentialRow(
            label: context.l10n.usernameEmail,
            value: creds.username,
            onCopy: () => _copyToClipboard(context, creds.username),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Divider(color: context.colors.surfaceContainerHighest, height: 1),
          ),
          _buildCredentialRow(
            label: context.l10n.password,
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
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: context.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colors.onSurface,
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
                  color: context.colors.secondary,
                ),
              ),
            IconButton(
              onPressed: onCopy,
              icon: Icon(Icons.content_copy, color: context.colors.secondary),
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
              backgroundColor: context.colors.primaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              shadowColor: context.colors.primaryContainer.withOpacity(0.2),
              elevation: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.goToLogin,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: context.colors.onPrimary,
                  ),
                ),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: context.colors.onPrimary, size: 20),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () {
            if (context.canPop()) context.pop();
          },
          icon: Icon(
            Icons.chevron_left,
            color: context.colors.onSurfaceVariant,
            size: 20,
          ),
          label: Text(
            context.l10n.goBack,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurfaceVariant,
            ),
          ),
          style: TextButton.styleFrom(foregroundColor: context.colors.primary),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        context.l10n.secureAccessFooter,
        style: const TextStyle(
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
      SnackBar(
        content: Text(context.l10n.copiedToClipboard),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
