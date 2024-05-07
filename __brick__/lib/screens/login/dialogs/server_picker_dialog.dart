import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/classes/server_class.dart';
import '../../../core/constants/ui.dart';
import '../../../widgets/MyButton.dart';


class ServerPickerDialog extends StatefulWidget {
  final List<Server> servers;
  final Server? currentServer;

  const ServerPickerDialog({Key? key, required this.servers, this.currentServer}) : super(key: key);

  @override
  State<ServerPickerDialog> createState() => _ServerPickerDialogState();
}

class _ServerPickerDialogState extends State<ServerPickerDialog> {

  Server? tmpServer;

  @override
  void initState() {
    tmpServer = widget.currentServer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      constraints: BoxConstraints(maxHeight: Get.height * 0.75),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              "Available Servers",
              style: TextStyles.styleBold16Black,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView(
              children: widget.servers.map((e) {
                return RadioListTile<Server>(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  groupValue: tmpServer,
                  activeColor: theme.primaryColor,
                  title: Text(e.name),
                  value: e,
                  onChanged: (Server? value) {
                    setState(() {
                      tmpServer = value;
                    });
                  },
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24,bottom: 24),
            child: Row(
              children: [
                const Spacer(),
                MyButton(
                  flat: true,
                  label: "Cancel",
                  color: Colors.grey,
                  onPressed: () {},
                ),
                const SizedBox(width: 24),
                MyButton(

                  label: "Apply",
                  onPressed: () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
