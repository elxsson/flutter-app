import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;

  const SearchBarWidget({
    super.key,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: widget.onChanged,
      onSubmitted: (_) => widget.onSubmitted?.call(),
      decoration: InputDecoration(
        hintText: 'Pesquisar livros...',
        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
        filled: true,
        fillColor: AppColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    );
  }
}
