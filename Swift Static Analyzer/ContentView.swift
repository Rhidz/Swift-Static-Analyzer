//
//  ContentView.swift
//  Swift Static Analyzer
//
//  Created by Admin on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        var a = Analyzer()
        Text(a.startAnalyzing())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
