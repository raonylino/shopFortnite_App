import 'package:flutter/material.dart';
import 'package:fortnite_flutter/core/theme/fortnite_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: FortniteTheme.appBarGradient),
      child: AppBar(
        title: Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
        leading: showBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                color: FortniteTheme.textPrimary,
              )
            : null,
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
