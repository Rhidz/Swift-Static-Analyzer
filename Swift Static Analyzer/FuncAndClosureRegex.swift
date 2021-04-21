//
//  FuncAndClosureRegex.swift
//  Swift Static Analyzer
//
//  Created by Admin on 29/01/2021.
//

import Foundation

let closureInsideFunc = try! NSRegularExpression(pattern: "\\B\\((\\w*,?\\s*\\)?)*\\s*->\\s*\\(?(\\w*,?)*\\)?")
let funcWithFourParams = try! NSRegularExpression(pattern: "\\bfunc .*\\((.*,){3,}.*\\)")
let closureWithFourParams = try! NSRegularExpression(pattern: "\\B\\((.*,){3,}.*\\)\\s*->\\s*[a-zA-Z\\(\\)]*")
let set: Set<Character> = ["(", ")", " ", "}", "{"]
let braces: Set<Character> = ["{", "}"]


