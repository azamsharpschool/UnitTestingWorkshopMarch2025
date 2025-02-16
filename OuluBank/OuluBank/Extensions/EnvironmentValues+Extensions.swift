//
//  EnvironmentValues+Extensions.swift
//  OuluBank
//
//  Created by Mohammad Azam on 2/3/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var aprService: APRServiceProtocol = APRService(creditScoreService: CreditScoreServiceFactory.current.service)
}
