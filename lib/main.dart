import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_builder/app.dart';
import 'package:flutter_widget_builder/config/theme.dart';
import 'package:flutter_widget_builder/features/bloc/widget_tree/widget_tree_bloc.dart';
import 'package:flutter_widget_builder/features/controller/interface_controller.dart';
import 'package:flutter_widget_builder/features/view/home/home_view.dart';
import 'package:flutter_widget_builder/features/view/playground.dart';

void main() {
  runApp(
    MyApp(
      fbController: FbInterfaceController(),
    ),
  );
}
