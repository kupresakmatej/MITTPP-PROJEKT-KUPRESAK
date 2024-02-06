//
//  SummaryFilter.swift
//  Shows
//
//  Created by Matej Kuprešak on 03.10.2023..
//

import Foundation
import SwiftUI

extension String {
    var removingHTMLTags: String {
        guard let data = self.data(using: .utf8) else { return self }
        do {
            let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributedString.string
        } catch {
            return self
        }
    }
}
