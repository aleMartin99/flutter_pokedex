// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';

// ///SearchBar class
// class SearchBar extends TextFormField {
//   ///
//   SearchBar({
//     required this.context,
//     super.key,
//     super.controller,
//     super.initialValue,
//     super.focusNode,
//     super.keyboardType,
//     super.textCapitalization,
//     super.textInputAction,
//     super.style,
//     super.strutStyle,
//     super.textDirection,
//     super.textAlign,
//     super.textAlignVertical,
//     super.autofocus,
//     super.readOnly,
//     super.showCursor,
//     super.obscuringCharacter,
//     super.obscureText,
//     super.autocorrect,
//     super.smartDashesType,
//     super.smartQuotesType,
//     super.enableSuggestions,
//     super.maxLengthEnforcement,
//     super.maxLines,
//     super.minLines,
//     super.expands,
//     super.maxLength,
//     super.onTap,
//     super.onTapOutside,
//     super.onEditingComplete,
//     super.onFieldSubmitted,
//     super.onSaved,
//     super.validator,
//     super.inputFormatters,
//     super.enabled,
//     super.cursorWidth,
//     super.cursorHeight,
//     super.cursorRadius,
//     super.cursorColor,
//     super.keyboardAppearance,
//     super.scrollPadding,
//     super.enableInteractiveSelection,
//     super.selectionControls,
//     super.buildCounter,
//     super.scrollPhysics,
//     super.autofillHints,
//     super.autovalidateMode,
//     super.scrollController,
//     super.restorationId,
//     super.enableIMEPersonalizedLearning,
//     super.mouseCursor,
//     super.contextMenuBuilder,
//     super.spellCheckConfiguration,
//     super.magnifierConfiguration,
//     super.undoController,
//     super.onAppPrivateCommand,
//     super.cursorOpacityAnimates,
//     super.selectionHeightStyle,
//     super.selectionWidthStyle,
//     super.dragStartBehavior,
//     super.contentInsertionConfiguration,
//     super.clipBehavior,
//     super.scribbleEnabled,
//     super.canRequestFocus,
//     InputDecoration decoration = const InputDecoration(),
//     String? hintText,
//   }) : super(
//           onChanged: (value) {
//             if (value.isNotEmpty) {
//               context
//                   .read<SearchBloc>()
//                   .add(SearchActivatedEvent(searchWord: value));
//             } else {
//               context.read<SearchBloc>().add(SearchDeactivatedEvent());
//             }
//           },
//           decoration: decoration.copyWith(
//             hintText: hintText,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(100),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 8, horizontal: 42),
//             filled: true,
//             fillColor: const Color.fromARGB(186, 226, 227, 230),
//             hintStyle: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: Colors.black.withOpacity(0.4),
//             ),
//             prefixIcon: const Icon(CupertinoIcons.search, size: 26),
//           ),
//         );

//   BuildContext context;
// }
