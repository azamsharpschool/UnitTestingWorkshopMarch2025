//
//  ContentView.swift
//  OuluBankR1
//
//  Created by Mohammad Azam on 2/13/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.aprService) private var aprService
    
    @State private var ssn: String = ""
    @State private var apr: Double?
    @State private var message: String?
    
    private var isFormValid: Bool {
        ssn.isSSN && !ssn.isEmptyOrWhiteSpace
    }
    
    var body: some View {
        Form {
            TextField("Enter ssn", text: $ssn)
                .accessibilityIdentifier("ssnTextField")
            Button("Calculate APR") {
                Task {
                    do {
                        apr = try await aprService.getAPR(ssn: ssn)
                    } catch {
                        message = error.localizedDescription
                    }
                }
            }
            .accessibilityIdentifier("calculateAPRButton")
            .disabled(!isFormValid)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity, alignment: .center)
            
            if let apr {
                Text("\(apr)")
                    .accessibilityIdentifier("aprText")
            }
            
            if let message {
                Text("\(message)")
                    .accessibilityIdentifier("messageText")
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
