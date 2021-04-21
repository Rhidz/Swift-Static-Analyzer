
//  ContentView.swift
//  Swift Static Analyzer
//
//  Created by Admin on 23/01/2021.
//

import Foundation

struct SwiftStaticAnalyzer {
    
    var contentsOfFile:[String]
    var getSubstringInRange: (NSRange, String) -> Substring = { $1[Range($0,in: $1)!] }
    var closuresInsideFunctions: [Substring] = []
    var funcContainsClosure: Bool?
    
    var printParams:(Substring) -> () = {
        let breakingPoint = $0.firstIndex(of: ":")
        let typeStartingIndex = $0.index(breakingPoint!, offsetBy: 1)
        print("Name: \($0[..<breakingPoint!]), Type: \($0[typeStartingIndex..<$0.endIndex]) \n")
      }
    
    var modify: (String) -> Substring = {
        let firstIndex = $0.index($0.firstIndex(of: "(")!, offsetBy: 1)
        let lastIndex = $0.lastIndex(of: ")")
        return $0[firstIndex..<lastIndex!]
    }
    
    //MARK: START PARSING STRING
    mutating func parser() -> String {
        for index in self.contentsOfFile.indices {
            closureOrFunc(in: contentsOfFile[index])
        }
        return "Started Static Analysis"
    }
    //MARK: CREATE TOKENS FOR FUNCTION DEFINITION
    mutating func notifyDeveloperOfParamsWithoutClosure(of pattern :Substring) {
        var remainingString = pattern
        remainingString.removeAll(where: {set.contains($0)})
        showTheParametersIn(substring: remainingString)
       
    }
       //MARK: SHOW PARAMETERS IN LENGHTY CLOSURES
    mutating func modifyStringForClosure(for range: NSRange, string: String) {
        var closurePattern = getSubstringInRange(range,string)
        print("You have a closure with more than three paramaters: \(closurePattern) \n")
        closurePattern.removeAll(where: {set.contains($0)})
        let closureParams = closurePattern.components(separatedBy: "->").dropLast()
        print("The Closure Parameters are: \(closureParams.first!.components(separatedBy: ",")) \n")
    }
      //MARK: INITIATE THE BREAKING DOWN OF A FUNCTION DEFINATION
    mutating func modifyStringForFunc(for range: NSRange, string: String) {
        if closureInsideFunc.firstMatch(in: string, options: [], range: range) != nil {
            funcContainsClosure = true
            let matches = closureInsideFunc.matches(in: string, options: [], range: range)
            createClosuresFor(substrings: matches.count, inString: string)
            
        } else {
            notifyDeveloperOfParamsWithoutClosure(of: modify(string))
        }
    }
    //MARK:- CLOSURE OR FUNCTION
    mutating func closureOrFunc(in string: String) {
        if let rangeForFunc = funcWithFourParams.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count)) {
            modifyStringForFunc(for: rangeForFunc.range, string: string)
        }
         else if let rangeForClosure = closureWithFourParams.firstMatch(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))  {
            modifyStringForClosure(for: rangeForClosure.range, string: string)
        }
    }
    //MARK:- FILL CLOSURES ARRAY
    mutating func createClosuresFor(substrings: Int, inString: String) {
        var nstr = inString
        for _ in 0..<substrings {
            if let rangeOfFirstMatch = closureInsideFunc.firstMatch(in: nstr, options: [], range: NSRange(location: 0, length: nstr.utf16.count)) {
                let subrange = Range(rangeOfFirstMatch.range, in: nstr)
                closuresInsideFunctions.append(nstr[subrange!])
                nstr.removeSubrange(subrange!)
            }
       }
        var substring = modify(nstr)
        substring.removeAll(where: {set.contains($0)})
        showTheParametersIn(substring: substring)
    }
    //MARK:- PRINT EVERYTHING
     mutating func showTheParametersIn(substring: Substring) {
        let tokens = substring.split(separator: ",")
        if funcContainsClosure == true {
            print("Parameters of functions that HAVE data types as closure are: \n")
            for indice in tokens.indices {
                if tokens[indice].last == ":" {
                    let name = tokens[indice]
                    let type = closuresInsideFunctions.removeFirst()
                    print("Name: \(name[..<name.firstIndex(of: ":")!]), Type: \(type) \n")
                } else {
                    printParams(tokens[indice])
                }} }
        else {
            print("Parameters of functions that DON'T have data types as closure are: \n")
            for indice in tokens.indices {
                printParams(tokens[indice])
         }}
 }
}

