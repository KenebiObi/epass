import 'package:flutter/material.dart';

class SaveScreenEditPassDialog extends StatefulWidget {
  SaveScreenEditPassDialog({
    required this.controller,
    required this.password,
    required this.executable,
    super.key,
  });

  TextEditingController controller = TextEditingController();
  TextEditingController password = TextEditingController();
  final void Function() executable;

  @override
  State<SaveScreenEditPassDialog> createState() =>
      _SaveScreenEditPassDialogState();
}

class _SaveScreenEditPassDialogState extends State<SaveScreenEditPassDialog> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return AlertDialog(
        title: const Text("Save Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: TextField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontFamily: "Karla",
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: constraints.maxWidth <= 305
                        ? "Account Name"
                        : "Name of account",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: constraints.maxWidth <= 305 ? 15.0 : 18.0,
                    ),
                    border: InputBorder.none,
                  ),
                  controller: widget.controller,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: TextField(
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    fontFamily: "Karla",
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 18.0,
                    ),
                    border: InputBorder.none,
                  ),
                  controller: widget.password,
                ),
              ),
            ),
          ],
        ),
        actions: [
          constraints.maxWidth <= 305
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 60.0)),
                  onPressed: () {
                    widget.executable();
                    widget.controller.clear();
                    widget.password.clear();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20.0),
                  ),
                )
              : const SizedBox(),
          constraints.maxWidth <= 305
              ? const SizedBox(height: 15.0)
              : const SizedBox(),
          constraints.maxWidth <= 305
              ? Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60.0),
                        ),
                        onPressed: () {
                          widget.executable();
                          widget.controller.clear();
                          widget.password.clear();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Save",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      );
    });
  }
}
