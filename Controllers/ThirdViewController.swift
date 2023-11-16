//
//  ThirdViewController.swift
//  QuotesApp


import UIKit

class ThirdViewController: UIViewController {
    
    private let toDoService = ToDoService.sharedConfiguration
    var categories: [String] = []
    
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
        title = "Categories"
        setupConstraints()
        toDoService.getCategories { [weak self] category in
            self?.categories = category
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
extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        categories.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        let category = categories[indexPath.row]
        cell.textLabel?.text = category
        return cell
         
        //UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row]
        let quotesVC = QuotesByCategoryViewController()
        quotesVC.selectedCategory = selectedCategory
        self.present(quotesVC, animated: true, completion: nil)
    }
    
    
}
