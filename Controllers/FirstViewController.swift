//
//  FirstViewController.swift
//  QuotesApp


import UIKit

class FirstViewController: UIViewController {
    
    private let networkService = NetworkService()
    private let toDoService = ToDoService()
    
    
    //MARK: -ui-
    
    lazy var loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load and save a quot", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.borderWidth = 0.5
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return(button)
       }()
    
    lazy var jokeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = " "
        label.layer.cornerRadius = 12
        label.layer.borderWidth = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: - methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Chuck Facts"
        setupConstraints()
    }
    
    
    @objc func buttonAction() {
        //loadButton.isEnabled = false
        networkService.fetchJoke { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let joke):
                    self?.jokeLabel.text = joke.value
                    if let category = joke.categories.first {
                        self?.toDoService.addQuots(quote: joke.value, category: category!)
                    } else {
                        self?.toDoService.addQuots(quote: joke.value, category: "no category")
                    }
                    
                case .failure(_):
                    self?.jokeLabel.text = "Error"
                }
                //self?.loadButton.isEnabled = true
            }
        }
    }
    //MARK: - constraints
    
    func setupConstraints() {
        view.addSubview(jokeLabel)
        view.addSubview(loadButton)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            jokeLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            jokeLabel.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            jokeLabel.widthAnchor.constraint(equalToConstant: 300),
            jokeLabel.heightAnchor.constraint(equalToConstant: 200),
            
            loadButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            loadButton.topAnchor.constraint(equalTo: jokeLabel.bottomAnchor, constant: 30),
            loadButton.widthAnchor.constraint(equalToConstant: 200),
            loadButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
    }
    


}

