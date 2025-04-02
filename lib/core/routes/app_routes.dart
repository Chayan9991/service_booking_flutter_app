import 'package:flutter/material.dart';

class AppRoutes {
  
  final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => navigationKey.currentState!; 

  void pop<T>(T? result){
    return _navigator.pop(result);
  }

  Future<T?> push<T>(Widget page){
    return _navigator.push<T>(
      MaterialPageRoute(builder: (_)=>page)
    );
  }

  Future<T?> pushReplacement<T>(Widget page){
    return _navigator.pushReplacement<T,dynamic>(
      MaterialPageRoute(builder: (_)=>page),
    );
  }

  Future<T?> pushAndRemoveUntil<T>(Widget page){
    return _navigator.pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_)=>page),
        (route) =>false
    );
  }

  Future<T?> pushNamed<T>(String routeName,{Object? arguments}){
    return _navigator.pushNamed<T>(
      routeName,
      arguments:arguments,
    );
  }
}
