//
//  LoginViewModel.swift
//  Assignment_Pushker
//
//  Created by Pushker Pandey on 11/03/25.
//

import RxSwift
import RxCocoa

class LoginViewModel {
    let email = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    
    var isFormValid: Observable<Bool> {
        return Observable.combineLatest(email, password) { email, password in
            return email.contains("@") && password.count >= 8 && password.count <= 15
        }
    }
}
