import Foundation
import UIKit

protocol TicketDetailPresenterOutputProtocol {
    func output()
    func buttonStateSafe() -> Bool
    func buttonTap(liked: inout Bool)
}

class TicketDatailPresenter: TicketDetailPresenterOutputProtocol {
    
    var ticket: Ticket
    
    var input: TicketDetailPresenterInputProtocol
    
    init(ticket: Ticket, input: TicketDetailPresenterInputProtocol) {
        self.ticket = ticket
        self.input = input
    }
    
    func output() {
        input.input(ticket: ticket)
    }
    
    func buttonStateSafe() -> Bool {
        UserDefaults.standard.bool(forKey: ticket.searchToken)
    }
    
    func buttonTap(liked: inout Bool) {
        switch UserDefaults.standard.bool(forKey: ticket.searchToken) {
        case true:
            UserDefaults.standard.set(false, forKey: ticket.searchToken)
        case false:
            UserDefaults.standard.set(true, forKey: ticket.searchToken)
        }
        liked = UserDefaults.standard.bool(forKey: ticket.searchToken)
    }
}
