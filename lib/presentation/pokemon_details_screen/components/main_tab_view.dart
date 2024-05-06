import 'package:flutter/material.dart';

///Main tab data class
class MainTabData {
  ///
  const MainTabData({
    required this.label,
    required this.child,
  });

  ///
  final Widget child;

  ///
  final String label;
}

///
class MainTabView extends StatelessWidget {
  ///
  const MainTabView({
    required this.tabs,
    super.key,
    this.paddingAnimation,
  });

  ///Tabs
  final List<MainTabData> tabs;

  ///padding animation
  final Animation<double>? paddingAnimation;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTopAnimatedPadding(),
            _buildTabBar(context),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopAnimatedPadding() {
    if (paddingAnimation == null) {
      return const SizedBox(height: 6);
    }

    return AnimatedBuilder(
      animation: paddingAnimation!,
      builder: (context, _) => SizedBox(
        height: (1 - paddingAnimation!.value) * 16 + 6,
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      unselectedLabelColor: Colors.black45,
      labelColor: Colors.black,
      labelPadding: const EdgeInsets.symmetric(vertical: 16),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Theme.of(context).colorScheme.primary,
      tabs: tabs.map((tab) => Text(tab.label)).toList(),
    );
  }

  Widget _buildTabContent() {
    return Expanded(
      child: TabBarView(
        children: tabs.map((tab) => tab.child).toList(),
      ),
    );
  }
}
