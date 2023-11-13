import 'package:flutter/material.dart';

// Navigates to the specified screen
navigateTo({required context, required screen, state}) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (BuildContext context) => screen),
  );
}

// Replaces previous screen from stack and sets new screen in the stack
navigateToReplace({required context, required screen}) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => screen));
}

// Removes all previous screens from the stack and sets new screen as the first screen
navigateAndRemoveUntil({required context, required screen}) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (Route<dynamic> route) => false);
}

// Removes current screen from the stack
navigateBack({required context}) {
  Navigator.pop(context);
}
