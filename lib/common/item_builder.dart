
import 'package:flutter/cupertino.dart';

typedef ItemBuilder<T> = Widget Function(
    BuildContext context, T data, int index);
