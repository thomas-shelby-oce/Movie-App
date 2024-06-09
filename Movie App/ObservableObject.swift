//
//  ObservableObject.swift
//  Movie App
//
//  Created by Anish Gupta on 08/06/24.
//

import Foundation

final class ObservableObject<T> {
    var value: T {
        didSet {
            listener?()
        }
    }
    
    private var listener: (() -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping () -> Void) {
        self.listener = listener
    }
}
