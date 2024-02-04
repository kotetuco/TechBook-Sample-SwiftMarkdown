//
//  SimpleMarkdownApp.swift
//  SimpleMarkdown
//
//  Created by 栗山徹 on 2024/02/04.
//

import SwiftUI

let sampleMarkdownText =
"""
# Title
This is a **simple** `swift-markdown` _sample_.
"""

@main
struct SimpleMarkdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(initialText: sampleMarkdownText)
        }
    }
}
