//
//  CellViewCell.swift
//  QuotesApp


import UIKit

class CellViewCell: UITableViewCell {
    
    //MARK: -ui-
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 16)
        return textView
    }()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(textView)
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - constraints
    
    func setupConstraint() {
        
        NSLayoutConstraint.activate([
            
            textView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        
        ])
        
    }
    
}


