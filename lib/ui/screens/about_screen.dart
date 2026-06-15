import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/app_bottom_nav.dart';

class AboutScreen extends HookWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;

          return Center(
            child: SizedBox(
              width: maxWidth,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    const Icon(
                      Icons.menu_book_rounded,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Book Finder',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Aplicativo de busca e exploração de livros que '
                      'consome a Open Library API. Desenvolvido como '
                      'projeto da disciplina de Programação Orientada '
                      'a Objetos.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary.withValues(alpha: 0.7),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.accent),
                    const SizedBox(height: 24),
                    const _SectionTitle('Tecnologias'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        'Flutter', 'flutter_hooks', 'GetX',
                        'http', 'cached_network_image', 'Open Library API',
                      ].map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tech,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.accent),
                    const SizedBox(height: 24),
                    const _SectionTitle('API'),
                    const SizedBox(height: 8),
                    Text(
                      'Dados fornecidos pela',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Open Library',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.accent,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(color: AppColors.accent),
                    const SizedBox(height: 24),
                    const _SectionTitle('Desenvolvedores'),
                    const SizedBox(height: 16),
                    const _DevCard(
                      name: 'Elisson da Silva Tavares',
                      ra: 'RA: 20250037481',
                      funcao: 'Função: Desenvolvedor Mobile',
                    ),
                    const SizedBox(height: 12),
                    const _DevCard(
                      name: 'Gabriel Victor de Souza Fernandes',
                      ra: 'RA: 20250061137',
                      funcao: 'Função: Desenvolvedor Mobile',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }
}

class _DevCard extends StatelessWidget {
  final String name;
  final String ra;
  final String funcao;

  const _DevCard({required this.name, required this.ra, required this.funcao});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 2),
              Text(
                ra,
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.primary.withValues(alpha: 0.6),
                ),
              ),

              const SizedBox(height: 4), // Dá um espacinho entre o RA e a Função
              Text(
                funcao,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primary.withOpacity(0.7), // Deixa a cor um pouco mais suave
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}