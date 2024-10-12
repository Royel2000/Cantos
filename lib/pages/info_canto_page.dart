import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/songs_model.dart';

class InfoCantoPage extends StatefulWidget {
  const InfoCantoPage({super.key});

  @override
  _InfoCantoPageState createState() => _InfoCantoPageState();
}

class _InfoCantoPageState extends State<InfoCantoPage> {
  double _fontSize = 20;
  bool _isBold = false;
  TextAlign _textAlign = TextAlign.center;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble("fontSize") ?? 20;
      _isBold = prefs.getBool("isBold") ?? false;
      _textAlign =
          TextAlign.values[prefs.getInt("textAlign") ?? 2]; // Default to center
    });
  }

  Future<void> _savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble("fontSize", _fontSize);
    await prefs.setBool("isBold", _isBold);
    await prefs.setInt("textAlign", _textAlign.index);
  }

  void _adjustFontSize(double sizeChange) {
    setState(() {
      _fontSize = (_fontSize + sizeChange).clamp(10, 50);
      _savePreferences();
    });
  }

  void _toggleBold() {
    setState(() {
      _isBold = !_isBold;
      _savePreferences();
    });
  }

  void _changeAlignment(TextAlign alignment) {
    setState(() {
      _textAlign = alignment;
      _savePreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as SongModel?;

    if (args == null) {
      return const ErrorPage();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        actions: [
          _buildTextOptionsAdjuster(),
        ],
      ),
      body: _SongContent(
        args: args,
        fontSize: _fontSize,
        isBold: _isBold,
        textAlign: _textAlign,
      ),
    );
  }

  IconButton _buildTextOptionsAdjuster() {
    return IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return _TextOptionsBottomSheet(
              onFontSizeChange: _adjustFontSize,
              onToggleBold: _toggleBold,
              onChangeAlignment: _changeAlignment,
              isBold: _isBold,
            );
          },
        );
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No se encontró la información de la canción.'),
      ),
    );
  }
}

class _SongContent extends StatelessWidget {
  final SongModel args;
  final double fontSize;
  final bool isBold;
  final TextAlign textAlign;

  const _SongContent({
    required this.args,
    required this.fontSize,
    required this.isBold,
    required this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, bottom: 15),
                child: Column(
                  children: [
                    _SongHeader(args: args),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        args.descripcion ?? 'Sin letra',
                        textAlign: textAlign,
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight:
                              isBold ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Primera Iglesia Bíblica Bautista de Felipe Carrillo Puerto",
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SongHeader extends StatelessWidget {
  final SongModel args;

  const _SongHeader({required this.args});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${args.id}",
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          args.title ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _TextOptionsBottomSheet extends StatelessWidget {
  final Function(double) onFontSizeChange;
  final VoidCallback onToggleBold;
  final Function(TextAlign) onChangeAlignment;
  final bool isBold;

  const _TextOptionsBottomSheet({
    required this.onFontSizeChange,
    required this.onToggleBold,
    required this.onChangeAlignment,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFontSizeOptions(),
          _buildBoldToggle(),
          _buildAlignmentOptions(),
        ],
      ),
    );
  }

  Row _buildFontSizeOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: _FontSizeButton(
            text: "A",
            sizeChange: -2,
            onPressed: () => onFontSizeChange(-2),
            fontSize: 10,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: _FontSizeButton(
            text: "A",
            sizeChange: 2,
            onPressed: () => onFontSizeChange(2),
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Row _buildBoldToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text("Negrita"),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(5, 5),
                      blurRadius: 10,
                      spreadRadius: 1),
                  const BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, -5),
                      blurRadius: 10,
                      spreadRadius: 1)
                ]),
            child: IconButton(
                onPressed: () => onToggleBold(),
                icon: const Icon(Icons.auto_stories_rounded))),
      ],
    );
  }

  Row _buildAlignmentOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: IconButton(
            icon: const Icon(Icons.format_align_left),
            onPressed: () => onChangeAlignment(TextAlign.left),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: IconButton(
            icon: const Icon(Icons.format_align_center),
            onPressed: () => onChangeAlignment(TextAlign.center),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(5, 5),
                    blurRadius: 10,
                    spreadRadius: 1),
                const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: IconButton(
            icon: const Icon(Icons.format_align_justify),
            onPressed: () => onChangeAlignment(TextAlign.justify),
          ),
        ),
      ],
    );
  }
}

class _FontSizeButton extends StatelessWidget {
  final String text;
  final double sizeChange;
  final Function onPressed;
  final double fontSize;

  const _FontSizeButton({
    required this.text,
    required this.sizeChange,
    required this.onPressed,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onPressed(),
      child: SizedBox(
        width: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
