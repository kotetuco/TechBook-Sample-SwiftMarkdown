//
//  MarkdownParser.swift
//  SimpleMarkdown
//
//  Created by 栗山徹 on 2024/02/04.
//

import Foundation
import Markdown

// MARK: - ブロック要素

enum MarkdownParagraphType {
    case heading(planeText: String, level: Int)
    case textParagraph
}

struct MarkdownParagraph: Identifiable {
    var id = UUID()
    var elements: [MarkdownElement]
    var type: MarkdownParagraphType
}

// MARK: - ブロック内の各要素

enum MarkdownElementType {
    case text(planeText: String)
    case strong(planeText: String)
    case emphasis(planeText: String)
    case inlineCode(planeText: String)
}

struct MarkdownElement: Identifiable {
    var id = UUID()
    var type: MarkdownElementType
}

// MARK: - SimpleMarkdownParser

struct SimpleMarkdownParser {
    func parse(with sourceText: String) -> [MarkdownParagraph] {
        let document = Document(parsing: sourceText)
        return scanTopLevelParagraphs(markupChildren: document.children)
    }

    func parseAndDebug(with sourceText: String) -> [MarkdownParagraph] {
        let document = Document(parsing: sourceText)
        print(document.debugDescription())
        return scanTopLevelParagraphs(markupChildren: document.children)
    }

    // Document下のトップレベルのパラグラフを解析する
    private func scanTopLevelParagraphs(markupChildren: MarkupChildren) -> [MarkdownParagraph] {
        return markupChildren.compactMap { markup in
            switch markup {
            case let heading as Heading:
                // TODO: Heading内での文字装飾に対応する
                return MarkdownParagraph(
                    elements: [],
                    type: .heading(planeText: heading.plainText, level: heading.level)
                )
            case let paragraph as Paragraph:
                return MarkdownParagraph(
                    elements: scanElements(markupChildren: paragraph.children),
                    type: .textParagraph
                )
            default:
                // 未サポートの要素
                return nil
            }
        }
    }

    // トップレベルのパラグラフの子要素を解析する
    private func scanElements(markupChildren: MarkupChildren) -> [MarkdownElement] {
        return markupChildren.compactMap { markup in
            switch markup {
            case let text as Text:
                return MarkdownElement(type: .text(planeText: text.plainText))
            case let strong as Strong:
                return MarkdownElement(type: .strong(planeText: strong.plainText))
            case let emphasis as Emphasis:
                return MarkdownElement(type: .emphasis(planeText: emphasis.plainText))
            case let inlineCode as InlineCode:
                // inlineCode.plainTextだと前後の"`"も含んだ文字列が取得されてしまうので注意
                return MarkdownElement(type: .inlineCode(planeText: inlineCode.code))
            default:
                // 未サポートの要素
                return nil
            }
        }
    }
}
