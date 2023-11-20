import 'dart:async';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

abstract class FormController {
  void dispose();
}

class FormControl<FormName extends Enum>
    with LoggerMixin<FormControl<FormName>> {
  /// Number of form fields available in the form
  final int _formLength;

  FormControl._(this._formLength);

  /// Factory method to initiate the FormControl with a given form length.
  static FormControl<T> initiate<T extends Enum>(int formLength) =>
      FormControl<T>._(formLength);

  /// Holds the current validity state of each form field.
  final Map<FormName, bool?> _fieldsValidityCurrentState = {};

  /// Holds the content of each form field.
  final Map<FormName, Object> _fieldsContent = {};

  /// Notifier to broadcast the overall form validity state.
  final ValueNotifier<bool> formValidValueNotifier = ValueNotifier<bool>(false);

  /// Broadcast stream controller for form field validity updates.
  final StreamController<(FormName, String?)> _formFieldValidityStream =
      StreamController<(FormName, String?)>.broadcast();

  /// Stream getter for form field validity updates.
  Stream<(FormName, String?)> get formStream => _formFieldValidityStream.stream;

  /// Gets the content of a form field with the specified content type.
  ContentType getContent<ContentType>(FormName formName) {
    final content = _fieldsContent[formName];
    if (content is! ContentType) {
      logError('Invalid content type');
      throw Exception('Invalid content type');
    }
    return content;
  }

  /// Validates a form field.
  void validate({
    required bool isValid,
    required String errorMessage,
    required Object content,
    required FormName currentFormFieldInUse,
  }) {
    logInformation('Validating ${currentFormFieldInUse.name} form field');

    // Update the validity state and content for the current form field.
    if (_fieldsValidityCurrentState[currentFormFieldInUse] == isValid) {
      return;
    }
    _fieldsValidityCurrentState[currentFormFieldInUse] = isValid;
    _fieldsContent[currentFormFieldInUse] = content;

    // Broadcast the validity update.
    _formFieldValidityStream.sink
        .add((currentFormFieldInUse, isValid ? null : errorMessage));

    // Update the overall form validity state.
    formValidValueNotifier.value = isFormValid;
  }

  /// Checks if the entire form is valid.
  bool get isFormValid =>
      _fieldsValidityCurrentState.values.every((element) => element == true) &&
      _formLength == _fieldsValidityCurrentState.length;

  /// Disposes of the FormControl, closing streams and clearing states.
  void dispose() {
    logInformation('Disposing form field for ${FormName.toString()}');
    _formFieldValidityStream.close();
    _fieldsValidityCurrentState.clear();
  }
}

/// An InheritedWidget that holds a [FormControl] instance for form state management.
class FormControlFormInheritedWidget<FormName extends Enum>
    extends InheritedWidget {
  /// Constructor for FormControlFormInheritedWidget.
  const FormControlFormInheritedWidget({
    Key? key,
    required this.formControl,
    required Widget child,
  }) : super(key: key, child: child);

  /// The [FormControl] instance associated with this widget.
  final FormControl<FormName> formControl;

  /// Retrieves the [FormControlFormInheritedWidget] instance from the given [BuildContext].
  static FormControlFormInheritedWidget<FormNameType>?
      maybeOf<FormNameType extends Enum>(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        FormControlFormInheritedWidget<FormNameType>>();
  }

  /// Retrieves the [FormControlFormInheritedWidget] instance from the given [BuildContext].
  ///
  /// Throws an assertion error if the widget is not found in the widget tree.
  static FormControlFormInheritedWidget<FormNameType>
      of<FormNameType extends Enum>(BuildContext context) {
    final FormControlFormInheritedWidget<FormNameType>? result =
        maybeOf<FormNameType>(context);
    assert(
        result != null, 'No FormControlFormInheritedWidget found in context');
    return result!;
  }

  /// Always returns false to prevent unnecessary widget rebuilds.
  @override
  bool updateShouldNotify(covariant FormControlFormInheritedWidget oldWidget) {
    return false;
  }
}

/// A wrapper for an application button that depends on the form state.
class AppButtonFormWrapper<FormName extends Enum> extends StatelessWidget {
  /// Constructor for AppButtonFormWrapper.
  const AppButtonFormWrapper({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  /// The child widget representing the button.
  final Widget child;

  /// Callback function to be executed when the button is pressed.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: FormControlFormInheritedWidget.of<FormName>(context)
          .formControl
          .formValidValueNotifier,
      builder: (context, value, valueChild) {
        // Use AppButton.crystalBlue with the specified onPressed callback.
        return AppButton.crystalBlue(
          onPressed: value ? onPressed : null,
          child: child,
        );
      },
    );
  }
}

/// A text form field widget that depends on the form state.
class AppTextFormField<FormName extends Enum> extends StatelessWidget {
  /// Constructor for AppTextFormField.
  const AppTextFormField({
    Key? key,
    required this.textFromFieldName,
    required this.onChanged,
    required this.name,
  }) : super(key: key);

  /// The form field identifier.
  final FormName textFromFieldName;

  /// Callback function to be executed when the text field value changes.
  final ValueChanged<(String, FormName)> onChanged;

  /// The name or hint text for the text field.
  final String name;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<(FormName, String?)>(
      stream: FormControlFormInheritedWidget.of<FormName>(context)
          .formControl
          .formStream
          .where((event) => textFromFieldName == event.$1),
      builder: (context, snapshot) {
        // Use AppTextFieldOutlined with the specified hintText, errorText, and onChanged callback.
        return AppTextFieldOutlined(
          hintText: name,
          errorText: snapshot.data?.$2,
          onChanged: (val) => onChanged((val, textFromFieldName)),
        );
      },
    );
  }
}
