import 'package:flutter/material.dart';
import 'package:flutter_chat_app/domain/models/chat.dart';
import 'package:flutter_chat_app/ui/widgets/chat_screen_widget.dart';
import 'package:flutter_chat_app/ui/widgets/main_screen.dart';

abstract class NavigationRoutesName {
  static const String mainScreen = '/main_screen';
  static const String chatScreen = '/chat_screen';
}

class MainNavigation {
  final initialRoute = NavigationRoutesName.mainScreen;
  final routes = <String, Widget Function(BuildContext)>{
    NavigationRoutesName.mainScreen: (context) => MainScreen.create(),
  };

  Route<Object> onGenerateRouteSetings(RouteSettings settings) {
    switch (settings.name) {
      case NavigationRoutesName.chatScreen:
        final chatSetings = settings.arguments as Chat;
        return MaterialPageRoute(
          builder: (context) => ChatScreenWidget(chatSetings: chatSetings),
        );
      default:
        const widget = Text('Errror!!!');
        return MaterialPageRoute(builder: ((context) => widget));
    }
  }
}
