import UIKit

protocol TicketsPresenterInput {
    func presenterInput(ticket: [Ticket])
    func toTicketsDetailView(factory: Factory, ticket: Ticket)
}

class TicketsViewController: UIViewController {
    
    var presenter: TicketsPresenterOutput?
    
    lazy var tickets: [Ticket] = [] {
        didSet {
            ticketsTableView.reloadData()
            ref.endRefreshing()
            for ticket in tickets {
                if !UserDefaults.standard.contains(key: ticket.searchToken) {
                    UserDefaults.standard.set(false, forKey: ticket.searchToken)
                }
            }
        }
    }
    
    private let ref = UIRefreshControl()
    
    private lazy var ticketsTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(TicketsTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.separatorColor = .purple
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        view.refreshControl = ref
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ticketsTableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        ref.beginRefreshing()
        presenter?.presenterOutput()
    }

    private func setupViews() {
        view.addSubview(ticketsTableView)
        view.backgroundColor = .white
        
        [ticketsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         ticketsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         ticketsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         ticketsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ].forEach {$0.isActive = true}
    }
}

extension TicketsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ticketsTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TicketsTableViewCell
        cell?.getModel(ticket: tickets[indexPath.item])
        cell?.ticket = tickets[indexPath.item]
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.toDetailController(ticket: tickets[indexPath.item])
        
    }
    
}

extension TicketsViewController: TicketsPresenterInput {
    
    func presenterInput(ticket: [Ticket]) {
        self.tickets = ticket
        ticketsTableView.dataSource = self
        ticketsTableView.delegate = self
    }
    
    func toTicketsDetailView(factory: Factory, ticket: Ticket) {
        navigationController?.pushViewController(factory.ticketDetailView(ticket: ticket), animated: true)
    }
}
