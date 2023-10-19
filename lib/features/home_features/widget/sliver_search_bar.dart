import 'package:flutter/material.dart';

import '../../../const/responsive.dart';
import '../../public_features/widget/search_bar_widget.dart';

class SliverSearchBar extends StatelessWidget {
  const SliverSearchBar({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      toolbarHeight: Responsive.isTablet(context) ? 80 : 65,
      pinned: true,elevation: 2,
      flexibleSpace: SearchBarWidget(),
    );
  }
}