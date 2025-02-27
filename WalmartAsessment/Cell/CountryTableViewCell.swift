//
//  CountryTableViewCell.swift
//  WalmartAsessment
//
//  Created by David Mottle on 2/26/25.
//

import UIKit

//MARK: - CountryTableViewCell
class CountryTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let codeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let capitalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(countryNameLabel)
        containerView.addSubview(codeLabel)
        containerView.addSubview(capitalNameLabel)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            countryNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            countryNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            
            codeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            codeLabel.centerYAnchor.constraint(equalTo: countryNameLabel.centerYAnchor),
            
            capitalNameLabel.topAnchor.constraint(equalTo: countryNameLabel.bottomAnchor, constant: 6),
            capitalNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            capitalNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    //MARK: - Configuring the cell
    func configure(country: Country) {
        countryNameLabel.text = "\(country.name), \(country.region)"
        codeLabel.text = country.code
        capitalNameLabel.text = country.capital
    }
}
