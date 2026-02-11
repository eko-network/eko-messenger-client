import 'package:eko_messenger/utils/emoji_text_style.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StyledEmojiPicker extends StatefulWidget {
  final TextEditingController textController;

  const StyledEmojiPicker({super.key, required this.textController});

  @override
  State<StyledEmojiPicker> createState() => _StyledEmojiPickerState();
}

class _StyledEmojiPickerState extends State<StyledEmojiPicker> {
  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = ShadTheme.of(context).colorScheme.muted;
    final Color iconColor = ShadTheme.of(context).colorScheme.mutedForeground;
    final Color iconSelectedColor = ShadTheme.of(context).colorScheme.primary;
    return SizedBox(
      child: EmojiPicker(
        textEditingController: widget.textController,
        customWidget: (config, state, showSearchView) =>
            _StyledEmojiLayout(config, state, showSearchView),
        config: Config(
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            backgroundColor: backgroundColor,
            columns: 8,
            emojiSizeMax:
                28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.20
                    : 1.0),
            recentsLimit: 28,
          ),
          categoryViewConfig: CategoryViewConfig(
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            iconColorSelected: iconSelectedColor,
          ),
        ),
      ),
    );
  }
}

class _StyledEmojiLayout extends EmojiPickerView {
  const _StyledEmojiLayout(super.config, super.state, super.showSearchBar);

  @override
  _StyledEmojiLayoutState createState() => _StyledEmojiLayoutState();
}

class _StyledEmojiLayoutState extends State<_StyledEmojiLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  late TextEditingController _searchController;
  final List<GlobalKey> _categoryKeys = [];
  final GlobalKey _scrollViewKey = GlobalKey();

  List<Emoji> _searchResults = [];
  bool _isSearching = false;
  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.state.categoryEmoji.length,
      vsync: this,
    );
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    // Initialize keys for each category
    for (var i = 0; i < widget.state.categoryEmoji.length; i++) {
      _categoryKeys.add(GlobalKey());
    }

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isProgrammaticScroll) return;
    if (_isSearching) return;

    final scrollViewContext = _scrollViewKey.currentContext;
    if (scrollViewContext == null) return;

    final renderBox = scrollViewContext.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final listTop = renderBox.localToGlobal(Offset.zero).dy;
    final buffer = 50.0;

    int activeIndex = 0;

    for (int i = 0; i < _categoryKeys.length; i++) {
      final key = _categoryKeys[i];
      final context = key.currentContext;
      if (context == null) continue;

      final headerBox = context.findRenderObject() as RenderBox?;
      if (headerBox == null) continue;

      final headerTop = headerBox.localToGlobal(Offset.zero).dy;

      if (headerTop <= listTop + buffer) {
        activeIndex = i;
      } else {
        break;
      }
    }

    if (_tabController.index != activeIndex) {
      _tabController.animateTo(activeIndex);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToCategory(int index) {
    if (index < 0 || index >= _categoryKeys.length) return;

    final key = _categoryKeys[index];
    final context = key.currentContext;

    if (context != null) {
      _isProgrammaticScroll = true;
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: 0.0, // Align to top
      ).then((_) => _isProgrammaticScroll = false);
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    final allEmojis = widget.state.categoryEmoji
        .expand((cat) => cat.emoji)
        .toList();

    setState(() {
      _isSearching = true;
      _searchResults = allEmojis.where((e) {
        return e.name.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final catConfig = widget.config.categoryViewConfig;

    if (_categoryKeys.length != widget.state.categoryEmoji.length) {
      _categoryKeys.clear();
      for (var i = 0; i < widget.state.categoryEmoji.length; i++) {
        _categoryKeys.add(GlobalKey());
      }
    }

    return Column(
      children: [
        _buildSearchBar(),

        Expanded(
          child: _isSearching
              ? _buildSearchResultsGrid()
              : _buildUnifiedEmojiList(),
        ),
        _buildBottomCategoryBar(catConfig),
      ],
    );
  }

  Widget _buildUnifiedEmojiList() {
    return CustomScrollView(
      key: _scrollViewKey,
      controller: _scrollController,
      slivers: [
        for (int i = 0; i < widget.state.categoryEmoji.length; i++) ...[
          SliverToBoxAdapter(
            child: Padding(
              key: _categoryKeys[i],
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                _getCategoryName(widget.state.categoryEmoji[i].category),
                style: ShadTheme.of(context).textTheme.h4.copyWith(
                  color: ShadTheme.of(context).colorScheme.foreground,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.config.emojiViewConfig.columns,
                crossAxisSpacing:
                    widget.config.emojiViewConfig.horizontalSpacing,
                mainAxisSpacing: widget.config.emojiViewConfig.verticalSpacing,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                return _buildEmojiButton(
                  widget.state.categoryEmoji[i].emoji[index],
                );
              }, childCount: widget.state.categoryEmoji[i].emoji.length),
            ),
          ),
        ],
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: widget.config.emojiViewConfig.backgroundColor,
      child: TextField(
        controller: _searchController,
        onChanged: _performSearch,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: ShadTheme.of(context).colorScheme.primary.withValues(
            alpha: 0.1,
          ), // Signal's Search Pill Color
          hintText: "Search emoji",
          hintStyle: TextStyle(
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: ShadTheme.of(context).colorScheme.mutedForeground,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResultsGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.config.emojiViewConfig.columns,
        crossAxisSpacing: widget.config.emojiViewConfig.horizontalSpacing,
        mainAxisSpacing: widget.config.emojiViewConfig.verticalSpacing,
      ),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        return _buildEmojiButton(_searchResults[index]);
      },
    );
  }

  Widget _buildEmojiButton(Emoji emoji) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          widget.state.onEmojiSelected(null, emoji);
        },
        child: Center(
          child: Text(
            emoji.emoji,
            style: emojiTextStyle(
              const TextStyle(fontSize: 28),
            ), // Adjust size as needed
          ),
        ),
      ),
    );
  }

  Widget _buildBottomCategoryBar(CategoryViewConfig catConfig) {
    if (_isSearching) return const SizedBox.shrink();

    return Container(
      height: 50,
      color: widget.config.emojiViewConfig.backgroundColor,
      child: TabBar(
        dividerColor: Colors.transparent,
        indicatorColor: Colors.transparent,
        controller: _tabController,
        labelColor: catConfig.iconColorSelected,
        unselectedLabelColor: catConfig.iconColor,
        onTap: (index) {
          _scrollToCategory(index);
        },
        tabs: widget.state.categoryEmoji.map((cat) {
          return Tab(icon: Icon(_getIconForCategory(cat.category), size: 24));
        }).toList(),
      ),
    );
  }

  IconData _getIconForCategory(Category category) {
    switch (category) {
      case Category.RECENT:
        return LucideIcons.clock;
      case Category.SMILEYS:
        return LucideIcons.smile;
      case Category.ANIMALS:
        return LucideIcons.pawPrint;
      case Category.FOODS:
        return LucideIcons.soup;
      case Category.ACTIVITIES:
        return LucideIcons.volleyball;
      case Category.TRAVEL:
        return LucideIcons.carFront;
      case Category.OBJECTS:
        return LucideIcons.lightbulb;
      case Category.SYMBOLS:
        return LucideIcons.squarePi;
      case Category.FLAGS:
        return LucideIcons.flag;
    }
  }

  String _getCategoryName(Category category) {
    switch (category) {
      case Category.RECENT:
        return 'Recent';
      case Category.SMILEYS:
        return 'Smileys & People';
      case Category.ANIMALS:
        return 'Animals & Nature';
      case Category.FOODS:
        return 'Food & Drink';
      case Category.ACTIVITIES:
        return 'Activities';
      case Category.TRAVEL:
        return 'Travel & Places';
      case Category.OBJECTS:
        return 'Objects';
      case Category.SYMBOLS:
        return 'Symbols';
      case Category.FLAGS:
        return 'Flags';
    }
  }
}
