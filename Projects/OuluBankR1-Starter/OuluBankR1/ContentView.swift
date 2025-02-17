//
//  ContentView.swift
//  OuluBankR1
//
//  Created by Mohammad Azam on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var ssn: String = ""
    @State private var apr: Double?
    
    var body: some View {
        Form {
            TextField("Enter ssn", text: $ssn)
                
            Button("Calculate APR") {
                
            }
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
