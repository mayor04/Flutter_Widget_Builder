enum FbChildType { single, multiple, none }

enum FbWidgetType {
  main,
  container,
  row,
  column,
  sizedBox,
  stack,
  expanded,
  text,
  positioned,
}

///If the type is group we should display
///the children based on the `FbGroupType`
enum FbInputType { small, expnaded, ltrb, group, color, dropdown }

enum FbGroupType {
  smallHW,
}

enum DropdownDefault {
  none,
}
