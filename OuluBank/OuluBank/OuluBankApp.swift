//
//  OuluBankApp.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/2/25.
//

import SwiftUI

@main
struct OuluBankApp: App {
    
    //let aprService = APRService(creditScoreService: CreditScoreServiceFactory.current.service)
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                APRHistoryView() 
            }
        }
    }
}
