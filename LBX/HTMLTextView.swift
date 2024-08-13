//
//  HTMLTextView.swift
//  LBX
//
//  Created by Ramanand Komarraju on 8/6/24.
//

import Foundation
import SwiftUI
import UIKit

// This is the UIViewRepresentable that wraps a UITextView to display HTML content
struct HTMLTextView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = true
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if let data = htmlContent.data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
                uiView.attributedText = attributedString
            } else {
                uiView.text = "Failed to render HTML content."
            }
        } else {
            uiView.text = "Invalid HTML content."
        }
    }
}
