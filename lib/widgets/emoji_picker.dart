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
  late PageController _pageController;
  late TextEditingController _searchController;

  List<Emoji> _searchResults = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.state.categoryEmoji.length,
      vsync: this,
    );
    _pageController = PageController();
    _searchController = TextEditingController();

    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        _pageController.jumpToPage(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    _searchController.dispose();
    super.dispose();
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

    return Column(
      children: [
        _buildSearchBar(),

        Expanded(
          child: _isSearching
              ? _buildSearchResultsGrid()
              : _buildCategoryPageView(),
        ),
        _buildBottomCategoryBar(catConfig),
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
            borderRadius: BorderRadius.circular(30.0), // Fully rounded pill
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

  Widget _buildCategoryPageView() {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.state.categoryEmoji.length,
      onPageChanged: (index) {
        _tabController.animateTo(index);
      },
      itemBuilder: (context, index) {
        final category = widget.state.categoryEmoji[index];
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.config.emojiViewConfig.columns,
          ),
          itemCount: category.emoji.length,
          itemBuilder: (context, i) {
            return _buildEmojiButton(category.emoji[i]);
          },
        );
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
              TextStyle(fontSize: 28),
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
          _pageController.jumpToPage(index);
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
}
