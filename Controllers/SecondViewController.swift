//
//  SecondViewController.swift
//  QuotesApp


import UIKit

class SecondViewController: UIViewController {
    
    private let toDoService = ToDoService()
    var quotes: [Quote] = []
    
    //MARK: -ui-
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Quot List"
        setupConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toDoService.getSortedQuotes { [weak self] sortedQuotes in
            self?.quotes = sortedQuotes
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: - constraints
    
    func setupConstraints() {
        
        view.addSubview(tableView)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: safeAreaGuide.widthAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
}

extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        quotes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let quot = quotes[indexPath.row]
        cell.textLabel?.text = quot.quote
        return cell
    }
    
    
}
