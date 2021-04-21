//
//  Analyzer.swift
//  Swift Static Analyzer
//
//  Created by Admin on 23/01/2021.
//

import Foundation

struct Analyzer {
    mutating func startAnalyzing() -> String {
        if let data = Bundle.main.url(forResource: "Text", withExtension: "txt") {
            if let contents = try? String(contentsOf: data) {
                let stringToParse = contents.components(separatedBy: "\n")
                var staticAnalyzer = SwiftStaticAnalyzer(contentsOfFile: stringToParse)
                let result = staticAnalyzer.parser()
                return result
            }
        }
        return ""
    }
}
