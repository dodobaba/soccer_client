import 'drawerItem.dart';
import '../main.dart';

class DrawerMenu {
  static List<DrawerItem> fetchAll() {
    return [
      DrawerItem('Home', Home, 'assets/icons/soccer-ball.png'),
      DrawerItem('League', LeaguePage , 'assets/icons/soccer-ball.png'),
      ];
  }
}
