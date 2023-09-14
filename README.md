# rubby (Typst package)

## Usage

```typst
#import "@preview/rubby:0.8.0": get-ruby

#let ruby = get-ruby(
  size: 0.5em,         // Ruby font size
  dy: 0pt,             // Vertical offset of the ruby
  pos: top,            // Ruby position (top or bottom)
  alignment: "center", // Ruby alignment ("center", "start", "between", "around")
  delimiter: "|",      // The delimiter between words
  auto-spacing: true,  // Automatically add necessary space around words
)

// Ruby goes first, base text - second.
#ruby[ふりがな][振り仮名]

Treat each kanji as a separate word:
#ruby[とう|きょう|こう|ぎょう|だい|がく][東|京|工|業|大|学]
```

If you don't want automatically wrap text with delimiter:

```typst
#let ruby = get-ruby(auto-spacing: false)
```

See also <https://github.com/rinmyo/ruby-typ/blob/main/manual.pdf> and `example.typ`.

## Notes

Original project is at <https://github.com/rinmyo/ruby-typ> which itself is
based on [the post](https://zenn.dev/saito_atsushi/articles/ff9490458570e1)
of 齊藤敦志 (Saito Atsushi). This project is a modified version of
[this commit](https://github.com/rinmyo/ruby-typ/commit/23ca86180757cf70f2b9f5851abb5ea5a3b4c6a1).

`auto-spacing` adds missing delimiter around the `content`/`string` which
then adds space around base text if ruby is wider than the base text.

Problems appear only if ruby is wider than its base text and `auto-spacing` is
not set to `true` (default is `true`).

You can always use a one-letter function (variable) name to shorten the
function call length (if you have to use it a lot), e.g., `#let r = get-ruby()`
(or `f` — short for furigana). But be careful as there are functions with names
`v` and `h` and there could be a new built-in function with a name `r` or `f`
which will break your document (Typst right now is in beta, so breaking changes
are possible).

Although you can open issues or send PRs, I won't be able to always reply
quickly (sometimes I'm very busy).

## Changelog

You can view the change log in the CHANGELOG.md file in the root of the project.

## License

This Typst package is licensed under AGPL v3.0. You can view the license in the
LICENSE file in the root of the project or at
<https://www.gnu.org/licenses/agpl-3.0.txt>. There is also a NOTICE file for
3rd party copyright notices.

Copyright (C) 2023  Andrew Voynov
