//
//  ContentView.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import SwiftUI

struct ContentView: View {
    
    //let aprService: APRService
    
    @Environment(\.aprService) private var aprService 
    
    @State private var ssn: String = ""
    @State private var apr: Double?
    
    private var isFormValid: Bool {
        !ssn.isEmptyOrWhiteSpace && ssn.isSSN
    }
    
    var body: some View {
        VStack {
            TextField("SSN", text: $ssn)
                .textFieldStyle(.roundedBorder)
                .accessibilityIdentifier("ssnTextField")
            Button("Calculate APR") {
                
                Task {
                    do {
                        apr = try await aprService.getAPR(ssn: ssn)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
            }
            .accessibilityIdentifier("calculateAPRButton")
            .buttonStyle(.borderedProminent)
            .disabled(!isFormValid)
            
            Text(apr != nil ? String(format: "%.3f", apr!) : " ")
                        .font(.largeTitle)
                        .opacity(apr == nil ? 0 : 1)
                        .accessibilityIdentifier("aprText")
            
        }.padding()
            
    }
}

#Preview {
    NavigationStack {
        //ContentView(aprService: APRService(creditScoreService: MockCreditScoreService()))
        ContentView()
    }
}
