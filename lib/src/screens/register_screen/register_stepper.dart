import 'package:flutter/material.dart';

class RegisterStepper extends StatefulWidget {
  @override
  _RegisterStepperState createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  int _currentStep = 0;

  List<Step> _mySteps = [
    Step(
      title: Text("Step 1"),
      content: Text("Hello!"),
      isActive: true,
    ),
    Step(
      title: Text("Step 2"),
      content: Text("World!"),
      // You can change the style of the step icon i.e number, editing, etc.
      state: StepState.editing,
      isActive: true,
    ),
    Step(
      title: Text("Step 3"),
      content: Text("Hello World!"),
      isActive: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
        toolbarOpacity: 0.9,
        elevation: 0.0,
      ),
      body: Container(
        child: Stepper(
          currentStep: _currentStep,
          steps: _mySteps,
          type: StepperType.vertical,
          onStepTapped: (step) {
            setState(() {
              _currentStep = step;
            });
          },
          onStepCancel: () {
            setState(() {
              if (_currentStep > 0) {
                _currentStep = _currentStep - 1;
              } else {
                _currentStep = 0;
              }
            });
          },
          onStepContinue: () {
            setState(() {
              if (_currentStep < _mySteps.length - 1) {
                _currentStep = _currentStep + 1;
              } else {
                _currentStep = 0;
              }
            });
          },
        ),
      ),
    );
  }
}
