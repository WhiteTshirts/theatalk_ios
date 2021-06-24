//
//  ViewModelProtocl.swift
//  theatalk-ios
//
//  Created by riku iwasaki on 2021/06/24.
//

import Foundation

protocol ViewModelErrorHandle {
    func ErrorHandle(e:APIError)->String
}
