//
//  ContentView.swift
//  SimpleMarkdown
//
//  Created by 栗山徹 on 2024/02/04.
//

import SwiftUI

struct ContentView: View {
    @State private var paragraphs: [MarkdownParagraph] = []
    let initialText: String

    var body: some View {
        VStack {
            MarkdownPreviewView(paragraphs: $paragraphs)
            Spacer()
        }
        .padding(8)
        .onAppear {
            paragraphs = SimpleMarkdownParser().parseAndDebug(with: initialText)
        }
    }
}

#Preview {
    let sourceTextForPreview =
"""
# Paragraph 1
**Strong**
# Paragraph 2
_emphasis_
# Paragraph 3
`inline`
"""
    return ContentView(initialText: sourceTextForPreview)
}
