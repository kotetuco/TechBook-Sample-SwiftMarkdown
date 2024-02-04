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
**try!** _Swift_ `Tokyo`
"""

@main
struct SimpleMarkdownApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(initialText: sampleMarkdownText)
        }
    }
}
