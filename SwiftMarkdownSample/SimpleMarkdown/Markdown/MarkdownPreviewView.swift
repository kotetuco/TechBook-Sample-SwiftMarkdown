//
//  MarkdownPreviewView.swift
//  SimpleMarkdown
//
//  Created by 栗山徹 on 2024/02/04.
//

import Foundation
import SwiftUI

struct MarkdownPreviewView: View {
    @Binding var paragraphs: [MarkdownParagraph]

    var body: some View {
        ParagraphViewGroup(paragraphs: $paragraphs)
    }
}

struct ParagraphViewGroup: View {
    @Binding var paragraphs: [MarkdownParagraph]

    var body: some View {
        ForEach($paragraphs) { paragraph in
            VStack {
                HStack(spacing: 2) {
                    ParagraphView(paragraph: paragraph)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(2)
        }
    }
}

struct ParagraphView: View {
    @Binding var paragraph: MarkdownParagraph

    var body: some View {
        switch paragraph.type {
        case .heading(let plainText, _):
            // TODO: headingのlevelに合わせて文字サイズを調整する
            Text(plainText)
                .font(.largeTitle)
                .fontWeight(.heavy)
        case .textParagraph:
            ElementViewGroup(elements: $paragraph.elements)
        }
    }
}

struct ElementViewGroup: View {
    @Binding var elements: [MarkdownElement]

    var body: some View {
        ForEach(elements) { element in
            switch element.type {
            case .text(let planeText):
                Text(planeText)
                    .font(.body)
            case .strong(let planeText):
                Text(planeText)
                    .font(.body)
                    .fontWeight(.heavy)
            case .emphasis(let planeText):
                Text(planeText)
                    .italic()
                    .font(.body)
            case .inlineCode(let planeText):
                Text(planeText)
                    .background(Color.gray.opacity(0.3))
                    .font(.system(.body, design: .rounded))
            }
        }
    }
}

#Preview {
    @State var paragraphsForPreview = [
        MarkdownParagraph(elements: [], type: .heading(planeText: "Title", level: 1)),
        MarkdownParagraph(elements: [MarkdownElement(type: .text(planeText: "This is a simple swift-markdown sample."))], type: .textParagraph)
    ]
    return VStack {
        MarkdownPreviewView(paragraphs: $paragraphsForPreview)
        Spacer()
    }
}
