import 'package:flutter/material.dart';

// ///This is where all widget appearance are being tested
class Playground extends StatelessWidget {
  const Playground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Wrap(
//           spacing: 15,
//           runSpacing: 15,
//           children: [
//             _PlayBorder(
//               child: Container(
//                 height: 50,
//                 width: 100,
//                 decoration: AppDecoration.lightBorder(
//                   color: AppColors.appGrey,
//                 ),
//               ),
//             ),
//             _PlayBorder(
//               child: Container(
//                 height: 50,
//                 width: 100,
//                 decoration: AppDecoration.darkBorder(color: AppColors.appGrey),
//               ),
//             ),
//             _PlayBorder(
//               child: SizedBox(
//                 width: 95,
//                 child: Row(
//                   children: [
//                     Text(
//                       'Width',
//                       style: context.textTheme.bodyMedium,
//                     ),
//                     const SizedBox(
//                       height: 30,
//                       width: 45,
//                       child: TextField(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             _PlayBorder(
//               title: 'Small input',
//               child: InputSmall(
//                 smallInputData: FbInputDataWrap('width', 2),
//                 onEditComplete: () {},
//               ),
//             ),
//             _PlayBorder(
//               title: 'Expanded input',
//               child: SizedBox(
//                 width: 275,
//                 child: InputExpanded(
//                   expandedInputData: FbInputDataExpanded('name', 2),
//                   onEditComplete: () {},
//                 ),
//               ),
//             ),
//             _PlayBorder(
//               title: 'LTRB input',
//               child: SizedBox(
//                 width: 275,
//                 child: InputLTRB(
//                   ltrbInputData: FbInputDataLTRB('margin', [0, 0, 0, 0]),
//                   onEditComplete: () {},
//                 ),
//               ),
//             ),
//             const _PlayBorder(
//               title: 'icon',
//               child: SizedBox(
//                 height: 30,
//                 width: 100,
//                 child: Icon(Icons.add),
//               ),
//             ),
//             _PlayBorder(
//               title: 'parse color',
//               child: Container(
//                 height: 50,
//                 width: 50,
//                 // color: Colors.white,
//                 color: () {
//                   int value = int.parse('0xFF7BBAAF');
//                   // var l = Color(value).toString();
//                   return Color(value);
//                 }(),
//               ),
//             ),
//             _PlayBorder(
//               child: SizedBox(
//                 width: 275,
//                 child: InputColor(
//                   colorInputData: FbInputDataColor('color', 0xFFC4C4C4),
//                   onEditComplete: () {},
//                 ),
//               ),
//             ),
//             _PlayBorder(
//               child: SizedBox(
//                 width: 275,
//                 child: InputDropdown(
//                   dropDownInputData: FbInputDataDropdown(
//                     'color',
//                     defaultEnum: MainAxisAlignment.center,
//                     list: MainAxisAlignment.values,
//                   ),
//                   onEditComplete: () {},
//                 ),
//               ),
//             ),
//             _PlayBorder(
//               child: Container(
//                 width: 175,
//                 padding: const EdgeInsets.fromLTRB(13, 10, 13, 10),
//                 decoration: AppDecoration.radius(
//                   color: AppColors.appGrey,
//                   radius: 3,
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     _MenuItem(text: 'Wrap With'),
//                     _MenuItem(text: 'Add'),
//                     _MenuItem(text: 'Remove'),
//                     Divider(color: Colors.white10, height: 15),
//                     _MenuItem(text: 'Copy'),
//                     _MenuItem(text: 'Cut'),
//                     _MenuItem(text: 'Paste as Child'),
//                     Divider(color: Colors.white10, height: 15),
//                     _MenuItem(text: 'Delete'),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  }

// class _MenuItem extends StatelessWidget {
//   final String text;
//   const _MenuItem({Key? key, required this.text}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       type: MaterialType.transparency,
//       borderRadius: BorderRadius.circular(4),
//       child: InkWell(
//         onTap: () {},
//         hoverColor: Colors.white10,
//         borderRadius: BorderRadius.circular(3),
//         child: Container(
//           alignment: Alignment.centerLeft,
//           padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
//           child: Text(
//             text,
//             style: context.textTheme.bodyMedium,
//           ),
//         ),
//       ),
//     );
//   }
}

// class GestWr extends StatefulWidget {
//   final Widget child;

//   const GestWr({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   State<GestWr> createState() => _GestWrState();
// }

// class _GestWrState extends State<GestWr> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<NotifierCubit, NotifierState>(
//       builder: (context, state) {
//         return widget.child;
//       },
//     );
//   }
// }

// class _PlayBorder extends StatelessWidget {
//   final Widget child;
//   final String? title;
//   const _PlayBorder({Key? key, required this.child, this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       decoration: AppDecoration.lightBorder(),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             title ?? 'No title',
//             style: context.textTheme.bodyMedium,
//           ),
//           const Box.vertical(10),
//           child,
//         ],
//       ),
//     );
//   }
// }
