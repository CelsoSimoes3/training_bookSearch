//
//  ServiceErrorEnum.swift
//  celsos_bookSearchTests
//
//  Created by Celso Junio Simões de Oliveira Santos on 18/06/21.
//

import Foundation
// Enum to Simulate Promise Errors
public enum ServiceError: Error {
    case urlMalFormatted
    case internetConnectionError
}
