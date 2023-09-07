//
//  AccountsUXFuncs.swift
//  CoinTail
//
//  Created by Eugene on 04.09.23.
//

import UIKit


extension AccountsVC {
    
    func sortAccounts() {
        accounts = Accounts.shared.accounts
                    
        // Отсортировать массив счетов по деньгам (убывание)
        accounts.sort { l, r in
            return l.amount > r.amount
        }
    }
    
    func accountButtonTargets() {
        transferButton.addTarget(self, action: #selector(goToAccountsTransferVC), for: .touchUpInside)
    }
    
}
