# AGENTS.md — Book Finder App (Flutter, POO)

## Contexto
Aplicativo de busca e exploração de livros consumindo a **Open Library API** (openlibrary.org).
A identidade visual é inspirada em um layout estilo "Coffee Shop" (tons quentes, arredondados), mas o domínio é 100% livros.

---

## Stack
- **Flutter** (foco mobile, responsivo para web/desktop)
- **flutter_hooks** — gerência de estado (`useState`, `useEffect`, `HookWidget`)
- **ValueNotifier** — notificação de mudanças de estado entre camadas
- **get (GetX)** — gerência de rotas (`Get.toNamed`, `getPages`, `initialRoute`)
- **http** — consumo da Open Library API
- **cached_network_image** — exibição de capas com cache

> **Por que flutter_hooks?** As receitas do material didático utilizam `flutter_hooks` com `useState`/`useEffect` e `HookWidget` como padrão para gerência de estado. `StatefulWidget` e `setState` não são utilizados.
> **Por que get?** A receita 9a utiliza `get` (GetX) para gerência de rotas com `Get.toNamed`, `getPages` e `initialRoute`. `go_router` e `Navigator` são mencionados como alternativas mas não são o padrão adotado no curso.

---

## Estrutura de pastas

```
lib/
├── main.dart
├── core/
│   ├── theme/
│   │   └── app_theme.dart
│   └── constants/
│       └── app_colors.dart
├── models/
│   ├── book.dart
│   ├── author.dart
│   └── subject.dart
├── services/
│   └── book_service.dart
├── data/
│   └── data_service.dart        # ValueNotifier com estado global da app
└── ui/
    ├── screens/
    │   ├── home_screen.dart
    │   ├── search_screen.dart
    │   ├── book_detail_screen.dart
    │   ├── author_screen.dart
    │   ├── subject_screen.dart
    │   └── about_screen.dart
    └── widgets/
        ├── book_card.dart
        ├── book_cover.dart
        ├── author_card.dart
        ├── search_bar_widget.dart
        ├── subject_chip.dart
        └── app_bottom_nav.dart

docs/
├── receita_01.md
├── receita_02.md
├── receita_03.md
├── receita_04.md
├── receita_05.md
├── receita_06.md
├── receita_07.md
├── receita_08.md
├── receita_08a.md
├── receita_09.md
└── receita_09a.md
```

**Regra:** telas em `screens/` são "burras" — apenas constroem UI e escutam o estado. Lógica de negócio e chamadas de API ficam em `services/` e `data/`.

---

## Cores (app_colors.dart)

```dart
class AppColors {
  static const primary    = Color(0xFF7E5349); // marrom escuro
  static const secondary  = Color(0xFFFDECD6); // creme claro
  static const accent     = Color(0xFFDBA67A); // caramelo
  static const background = Color(0xFFE0E0E0); // cinza claro
  static const white      = Color(0xFFFFFFFF);
}
```

---

## Regras de UI

| Elemento       | Regra                                                        |
|----------------|--------------------------------------------------------------|
| BorderRadius   | 16px padrão; 24px em search bars (pill shape)               |
| Botões         | fundo `primary`, texto `secondary`, altura 50px, radius 16  |
| Cards de livro | fundo `secondary`, sombra leve, radius 16                   |
| Search bar     | fundo branco, radius 24, ícone de lupa em `primary`         |
| AppBar         | fundo `secondary`, ícones e texto em `primary`              |
| Capas          | radius 12, `CachedNetworkImage` + placeholder com ícone     |
| Bottom nav     | fundo `secondary`, item ativo em `primary`                  |

### Responsividade
- Usar `LayoutBuilder` / `MediaQuery` em todas as telas
- No web (desktop): conteúdo centralizado, largura máxima **700px**
- No mobile: ocupa toda a largura

---

## Telas (6 funcionalidades)

### 1. Home (`/`)
- Seção "Em alta" — consumindo `GET /trending/daily.json`
- Carrossel horizontal de capas com título e autor
- Chips de subjects populares fixos (ex: fiction, science, history)
- Ao clicar num livro → `Get.toNamed('/book', arguments: olid)`
- Ao clicar num chip → `Get.toNamed('/subject', arguments: name)`

### 2. Search (`/search`)
- Barra de pesquisa funcional com debounce (~400ms) usando `useEffect`
- Filtros por: **título** (`q=`), **autor** (`author=`), **assunto** (`subject=`)
- Estado gerenciado com `useState` para query e filtro ativo
- Resultados em lista com capa, título e autor
- Estados: loading, lista vazia e erro tratados separadamente

### 3. Book Detail (`/book`)
- Consumindo `GET /works/{olid}.json`
- Capa em tamanho grande (`-L.jpg`)
- Título, autores (clicáveis → `/author`), ano, descrição
- Subjects como chips clicáveis → `/subject`

### 4. Author (`/author`)
- Consumindo `GET /authors/{olid}.json` + `GET /authors/{olid}/works.json`
- Foto do autor via `covers.openlibrary.org/a/olid/{olid}-M.jpg`
- Nome, bio, data de nascimento/falecimento
- Lista de obras clicáveis

### 5. Subject (`/subject`)
- Consumindo `GET /subjects/{name}.json?details=true&limit=20`
- Grid de livros do subject
- Autores mais prolíficos (via `details=true`)
- Paginação via `useEffect` com offset

### 6. About (`/about`)
- Informações sobre o app e o desenvolvedor
- Tecnologias utilizadas
- Link para a Open Library

---

## API — Open Library

**Base URL:** `https://openlibrary.org`
**Sem autenticação** — uso público e gratuito.

| Funcionalidade       | Endpoint                                                        |
|----------------------|-----------------------------------------------------------------|
| Trending diário      | `GET /trending/daily.json`                                      |
| Busca geral          | `GET /search.json?q={query}&limit=20&page=1`                    |
| Busca por autor      | `GET /search.json?author={author}&limit=20`                     |
| Busca por assunto    | `GET /search.json?subject={subject}&limit=20`                   |
| Detalhe do livro     | `GET /works/{olid}.json`                                        |
| Detalhe do autor     | `GET /authors/{olid}.json`                                      |
| Obras do autor       | `GET /authors/{olid}/works.json`                                |
| Assunto (+ detalhes) | `GET /subjects/{name}.json?details=true&limit=20&offset=0`      |
| Capa do livro (M)    | `https://covers.openlibrary.org/b/id/{cover_id}-M.jpg`          |
| Capa do livro (L)    | `https://covers.openlibrary.org/b/id/{cover_id}-L.jpg`          |
| Foto do autor        | `https://covers.openlibrary.org/a/olid/{olid}-M.jpg`            |

---

## Models

### Book
```dart
class Book {
  final String key;             // ex: /works/OL45804W
  final String title;
  final List<String> authors;
  final List<String> authorKeys;
  final int? coverId;
  final int? firstPublishYear;
  final List<String> subjects;
  final String? description;
}
```

### Author
```dart
class Author {
  final String key;
  final String name;
  final String? bio;
  final String? birthDate;
  final String? deathDate;
  final String? olid;
}
```

### Subject
```dart
class Subject {
  final String name;
  final int workCount;
  final List<Book> works;
  final List<Author> topAuthors;
}
```

---

## Gerência de estado (flutter_hooks + ValueNotifier)

```dart
// Tela que usa estado local com hooks
class SearchScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final query = useState('');
    final filter = useState('title'); // 'title' | 'author' | 'subject'
    final results = useState<List<Book>>([]);
    final isLoading = useState(false);

    useEffect(() {
      // debounce e chamada à API quando query muda
      ...
      return null;
    }, [query.value]);

    return ...;
  }
}

// Estado global via ValueNotifier (para trending e dados compartilhados)
class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
  });

  void carregarTrending() { ... tableStateNotifier.value = {...}; }
}
```

---

## Gerência de rotas (get/GetX)

```dart
// main.dart
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/',        page: () => HomeScreen()),
        GetPage(name: '/search',  page: () => SearchScreen()),
        GetPage(name: '/book',    page: () => BookDetailScreen()),
        GetPage(name: '/author',  page: () => AuthorScreen()),
        GetPage(name: '/subject', page: () => SubjectScreen()),
        GetPage(name: '/about',   page: () => AboutScreen()),
      ],
    );
  }
}

// Navegação
Get.toNamed('/book', arguments: olid);
Get.toNamed('/author', arguments: authorOlid);
Get.toNamed('/subject', arguments: subjectName);
Get.back();
```

---

## Boas práticas obrigatórias

- ❌ Sem `StatefulWidget` — estado via `HookWidget` + `useState`/`useEffect`
- ❌ Sem `setState` em nenhuma parte do código
- ❌ Sem rebuild desnecessário de telas inteiras
- ✅ Widgets reutilizáveis em `ui/widgets/`
- ✅ `BookService` como única classe que faz chamadas HTTP
- ✅ `DataService` com `ValueNotifier` para estado compartilhado entre telas
- ✅ Comentar as partes-chave (hooks, service, rotas) para a apresentação
- ✅ Tratar erros de rede (timeout, 404, sem conexão)
- ✅ Debounce de ~400ms na barra de pesquisa via `useEffect`
- ✅ Consultar `/docs` durante o desenvolvimento para referência das receitas
