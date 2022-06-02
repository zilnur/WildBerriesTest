import Foundation
import UIKit

class Factory {
    
    func ticketsView() -> TicketsViewController {
        let VC = TicketsViewController()
        let presenter = TicketsPresenter(input: VC)
        presenter.factory = self
        VC.presenter = presenter
        return VC
    }
    
    func ticketDetailView(ticket: Ticket) -> TicketDetailViewController {
        let vc = TicketDetailViewController()
        let presenter = TicketDatailPresenter(ticket: ticket, input: vc)
        vc.output = presenter
        vc.modalPresentationStyle = .pageSheet
        return vc
    }
}
