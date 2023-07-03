import 'package:flutter/material.dart';

InputDecoration inputTheme(
    BuildContext context, String hintText, String label, Icon prefix) {
  var sw = MediaQuery.of(context).size.width;

  return InputDecoration(
    label: Text(label),
    prefixIcon: prefix,
    //focusColor: ,
    counterText: '',
    filled: true,

    fillColor: Theme.of(context).colorScheme.tertiaryContainer,

    // border: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //     borderSide: BorderSide(color: Colors.transparent, width: .5)),

    //contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 0),
    // contentPadding:
    //     EdgeInsets.symmetric(vertical: sw / 16, horizontal: sw / 16),
    ///////
    // border: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //     borderSide: BorderSide(
    //         color: Theme.of(context).colorScheme.primaryContainer, width: .5)
    //         ),
    // enabledBorder: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //     borderSide: BorderSide(
    //         color: Theme.of(context).colorScheme.secondaryContainer,
    //         width: .75)),
    // focusedBorder: OutlineInputBorder(
    //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    //     borderSide: BorderSide(
    //         color: Theme.of(context).colorScheme.secondaryContainer, width: 1)),
    border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: .5)),
    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: .75)),
    focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(color: Colors.transparent, width: 1)),
    hintText: hintText,
    prefixIconColor: Theme.of(context).colorScheme.secondaryContainer,

    // prefixStyle: Theme.of(context).textTheme.headlineMedium,
    //filled: true,
    //fillColor: Theme.of(context).colorScheme.tertiary,
    // hintStyle: Theme.of(context).textTheme.headlineMedium,
    labelStyle: Theme.of(context).textTheme.headlineMedium,
    hintStyle: Theme.of(context).textTheme.headlineMedium,
    //suffixStyle: Theme.of(context).textTheme.headlineMedium,
    helperStyle: Theme.of(context).textTheme.headlineMedium,
    errorStyle: Theme.of(context).textTheme.displayMedium,
    // helperStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
    //       color: Theme.of(context).brightness == Brightness.dark
    //           ? Colors.blue
    //           : Colors.black,
    //     ),
  );
}
