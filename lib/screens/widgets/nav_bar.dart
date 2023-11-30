part of '../scaffold.dart';

Widget navbar(int currentIndex, Function change) {
  List<Color> colors = [
    const Color(0xff0FD481),
    Colors.deepOrange,
    const Color(0xff0FD481),
    const Color(0xff0FD481),
    Colors.blueGrey
  ];
  return SnakeNavigationBar.color(
    // padding: EdgeInsets.only(bottom: 5),
    // behaviour: SnakeBarBehaviour.pinned,
    snakeShape: SnakeShape.indicator.copyWith(
      centered: true,
      // padding: const EdgeInsets.all(8),
    ),
    backgroundColor: Colors.blueGrey.withOpacity(0.03),

    ///configuration for SnakeNavigationBar.color
    snakeViewColor: colors[currentIndex],
    selectedItemColor: colors[currentIndex],
    unselectedItemColor: Colors.blueGrey.withOpacity(0.7),
    height: 70,
    elevation: 0,
    selectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    currentIndex: currentIndex,
    onTap: (index) => change(index),
    items: [
      BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.solidUser, size: 22),
          label: "navprofile".tr),
      BottomNavigationBarItem(
          icon: const Icon(FontAwesomeIcons.suitcase, size: 22),
          label: "booking".tr),
      BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.house, size: 22),
          label: "navhome".tr),
      BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass, size: 22),
          label: "navsearch".tr),
      BottomNavigationBarItem(
          icon: const FaIcon(FontAwesomeIcons.gear, size: 22),
          label: "navsetting".tr),
    ],
  );
}
