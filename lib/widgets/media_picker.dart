import 'package:eko_messenger/widgets/emoji_picker.dart';
import 'package:eko_messenger/widgets/gif_picker.dart';
import 'package:flutter/material.dart';
import 'package:klipy_dart/klipy_dart.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MediaPicker extends StatefulWidget {
  final TextEditingController textController;
  final Function(KlipyResultObject) onGifSelected;

  const MediaPicker({
    super.key,
    required this.textController,
    required this.onGifSelected,
  });

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final KlipyClient? klipyClient;

  @override
  void initState() {
    super.initState();
    const apiKey = String.fromEnvironment('KLIPY_API_KEY');
    if (apiKey.isNotEmpty) {
      klipyClient = KlipyClient(apiKey: apiKey);
    } else {
      klipyClient = null;
    }
    _tabController = klipyClient == null
        ? TabController(length: 1, vsync: this, initialIndex: 0)
        : TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.muted,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: ShadTheme.of(context).colorScheme.primary,
            unselectedLabelColor: ShadTheme.of(
              context,
            ).colorScheme.mutedForeground,
            indicatorColor: ShadTheme.of(context).colorScheme.primary,
            dividerColor: ShadTheme.of(context).colorScheme.border,
            tabs: [
              Tab(text: "Emoji"),
              if (klipyClient != null) Tab(text: "GIFs"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                StyledEmojiPicker(textController: widget.textController),
                if (klipyClient != null)
                  GifPicker(
                    onGifSelected: widget.onGifSelected,
                    client: klipyClient!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
