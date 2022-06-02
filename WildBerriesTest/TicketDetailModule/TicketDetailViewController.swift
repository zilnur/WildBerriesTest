import UIKit

protocol TicketDetailPresenterInputProtocol {
    func input(ticket: Ticket)
}

class TicketDetailViewController: UIViewController {
    
    var output: TicketDetailPresenterOutputProtocol?
    
    var liked = false {
        didSet {
            switch liked {
            case false:
                self.likeButton.isSelected = false
                self.likeButton.backgroundColor = .gray
            default:
                self.likeButton.isSelected = true
                self.likeButton.backgroundColor = .purple
            }
        }
    }

    private let startCityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    private let startDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13)
        view.textColor = .systemGray
        return view
    }()
    
    private let endCityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17)
        return view
    }()
    
    private let endDateLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 13)
        view.textColor = .systemGray
        return view
    }()
    
    private let priceLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 20)
        view.text = "Цена:"
        return view
    }()
    
    private let priceValueLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        var view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Нравится?", for: .normal)
        view.setTitle("Нравится!", for: .selected)
        view.setTitleColor(UIColor.black, for: .normal)
        view.setTitleColor(UIColor.white, for: .selected)
        view.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        liked = output!.buttonStateSafe()
        setupView()
        output?.output()
    }
    
    private func setupView() {
        
        view.backgroundColor = .white
        
        [startCityLabel, startDateLabel, endCityLabel, endDateLabel,priceLabel, priceValueLabel, likeButton].forEach(view.addSubview(_:))
        
        [startCityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         startCityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
         
         startDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         startDateLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 30),
         
         endCityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         endCityLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 50),
         
         endDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         endDateLabel.topAnchor.constraint(equalTo: endCityLabel.bottomAnchor, constant: 30),
         
         priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         priceLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 50),
         
         priceValueLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
         priceValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         
         likeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         likeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
         likeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
         likeButton.heightAnchor.constraint(equalToConstant: 50)
        ].forEach {$0.isActive = true}
        
    }
    
    @objc func tapLikeButton() {
        output?.buttonTap(liked: &liked)
    }
}

extension TicketDetailViewController: TicketDetailPresenterInputProtocol {
    
    func input(ticket: Ticket) {
        self.startCityLabel.textWithImage(imageName: "airplane.departure", text: ticket.startCity)
        self.startDateLabel.text = ticket.startDate.toDate()
        self.endCityLabel.textWithImage(imageName: "airplane.arrival", text: ticket.endCity)
        self.endDateLabel.text = ticket.endDate.toDate()
        self.priceValueLabel.text = String(describing: ticket.price)
    }
    
}
