import UIKit

class TicketsTableViewCell: UITableViewCell {
    
    var ticket: Ticket?
    
    private let startCityLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 17)
        view.tintColor = .purple
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
        view.tintColor = .purple
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
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        view.addTarget(self, action: #selector(tapLikeButton), for: .touchUpInside)
        view.tintColor = .purple
        return view
    }()
    
    private var liked = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        [startCityLabel, startDateLabel, endCityLabel, endDateLabel, priceLabel, likeButton].forEach(contentView.addSubview(_:))
        
        [startCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         startCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         
         endCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
         endCityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         
         startDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         startDateLabel.topAnchor.constraint(equalTo: startCityLabel.bottomAnchor, constant: 10),
         
         endDateLabel.topAnchor.constraint(equalTo: endCityLabel.bottomAnchor, constant: 10),
         endDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         
         priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
         priceLabel.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 10),
         
         likeButton.topAnchor.constraint(equalTo: endDateLabel.bottomAnchor, constant: 10),
         likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
         likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ].forEach {$0.isActive = true}
    }
    
    @objc func tapLikeButton() {
        switch likeButton.state {
        case .normal, .highlighted:
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) { [self] in
                    self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                    likeButton.isSelected = true
                }
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                    self.likeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                }
            }
        default:
            likeButton.isSelected = false
        }
        switch UserDefaults.standard.bool(forKey: ticket!.searchToken) {
        case true:
            UserDefaults.standard.set(false, forKey: ticket!.searchToken)
        case false:
            UserDefaults.standard.set(true, forKey: ticket!.searchToken)
        }
        liked = UserDefaults.standard.bool(forKey: ticket!.searchToken)
    }
}

extension TicketsTableViewCell {
    func getModel(ticket: Ticket) {
        self.startCityLabel.textWithImage(imageName: "airplane.departure", text: ticket.startCity)
        self.startDateLabel.text = ticket.startDate.toDate()
        self.endDateLabel.text = ticket.endDate.toDate()
        self.endCityLabel.textWithImage(imageName: "airplane.arrival", text: ticket.endCity)
        self.priceLabel.text = String(describing: ticket.price)
        self.likeButton.isSelected = UserDefaults.standard.bool(forKey: ticket.searchToken)
    }
}
