//
//  QuotesByCategoryViewController.swift
//  QuotesApp


import UIKit

class QuotesByCategoryViewController: UIViewController {
    
    private let toDoService = ToDoService.sharedConfiguration
    var selectedCategory: String?
    var quotesOfCategory: [Quote] = []
    
    //MARK: -ui-
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            CellViewCell.self,
            forCellReuseIdentifier: "cell"
        )
        return tableView
    }()
    
    //MARK: - methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupConstraints()
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toDoService.oneCategoryList(category: selectedCategory!) { [weak self] quote in
            self?.quotesOfCategory = quote
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

extension QuotesByCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quotesOfCategory.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath
        ) as? CellViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        let quotes = quotesOfCategory[indexPath.row]
        cell.textView.text = quotes.quote

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Category: \(selectedCategory!)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight = UITableView.automaticDimension
        return tableView.rowHeight
    }
    
}

