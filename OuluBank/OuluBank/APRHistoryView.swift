//
//  APRHistoryView.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/3/25.
//

import SwiftUI

struct APRHistoryView: View {
    
    @Environment(\.aprService) private var aprService
    @State private var aprHistoricalData: [APRHistory] = []
    
    var body: some View {
        List(aprHistoricalData) { aprHistory in
            HStack {
                Text(aprHistory.scoreRange)
                Spacer()
                Text("\(aprHistory.apr)")
            }
        }.task {
            do {
                aprHistoricalData = try await aprService.getAPRHistory()
                print(aprHistoricalData)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    APRHistoryView()
        .environment(\.aprService, MockAPRService()) // stub/fake data
}
