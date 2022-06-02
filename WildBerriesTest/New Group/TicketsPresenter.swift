import Foundation
import UIKit

protocol TicketsPresenterOutput {
    func presenterOutput()
    func toDetailController(ticket: Ticket)
}

class TicketsPresenter: TicketsPresenterOutput {

    private let network = NetworkService()
    
    private var tickets: [Ticket]?
    
    var factory: Factory?
    
    let input: TicketsPresenterInput
    
    init(input: TicketsPresenterInput) {
        self.input = input
    }
    
    func presenterOutput() {
        network.getTickets { [self] request in
            tickets = request.data
            guard let uTickets = tickets else { return }
            DispatchQueue.main.async { [self] in
                input.presenterInput(ticket: uTickets)
            }
        }
    }
    
    func toDetailController(ticket: Ticket) {
        guard let factory = factory else {
            return
        }
        input.toTicketsDetailView(factory: factory, ticket: ticket)
    }
}
