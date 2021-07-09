import 'package:flutter/material.dart';


const double DEFAULT_LEFTRIGHT = 24;

Padding padLR(Widget widget, { double padding = DEFAULT_LEFTRIGHT }) => Padding(
  padding: EdgeInsets.symmetric(horizontal: padding),
  child: widget,
);

double safeHeight(BuildContext context) =>
  MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom;


Widget wrapWidgetWithInputFields(BuildContext context, Widget widget) => _unfocus(
  context,
  _keyboardScroll(context, widget),
);

// Wrap the body of a widget in this to remove focus when a non-interactable widget is tapped
Widget _unfocus(BuildContext context, Widget body) => GestureDetector(
  onTap: () {
    FocusScope.of(context).unfocus();
  },
  behavior: HitTestBehavior.opaque,
  child: body,
);

class NoGlowScrollBehvior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) => child;
}

// Wrap a widget in this to allow screen to move when keyboard is shown
// https://stackoverflow.com/questions/46551268/when-the-keyboard-appears-the-flutter-widgets-resize-how-to-prevent-this
// https://stackoverflow.com/questions/51119795/how-to-remove-scroll-glow
Widget _keyboardScroll(BuildContext context, Widget body) => ScrollConfiguration(
  behavior: NoGlowScrollBehvior(),
  child: SingleChildScrollView(
    physics: ClampingScrollPhysics(),
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: safeHeight(context) + MediaQuery.of(context).padding.bottom,
        maxHeight: safeHeight(context) + MediaQuery.of(context).padding.bottom,
      ),
      child: IntrinsicHeight(child: body),
    ),
  ),
);


/* Go to next editable field
https://stackoverflow.com/questions/52150677/how-to-shift-focus-to-next-textfield-in-flutter */
void nextEditableTextFocus(BuildContext context, FocusNode node) {
  do {
    node.nextFocus();
  } while (FocusScope.of(context).focusedChild!.context!.widget is! EditableText);
}

/* Same as SafeArea, but forces theme background in unsafe areas */
Widget safeAreaWithBG(BuildContext context, Widget body) => Container(
  color: Theme.of(context).backgroundColor,
  child: SafeArea(
    bottom: false,
    child: body,
  ),
);
