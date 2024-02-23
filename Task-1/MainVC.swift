

import Foundation
import UIKit

final class MainVC: UIViewController {
    
    private lazy var minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("The team missed the goal", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.addTarget(self, action: #selector(minusButtonDidTap(_: )), for: .touchUpInside)
        return button
    } ()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("The team scored the goal", for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 20
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.addTarget(self, action: #selector(plusButtonDidTap(_: )), for: .touchUpInside)
        return button
    } ()
    
    private lazy var scoredGoalsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .systemFont(ofSize: 60)
        return label
    } ()
    
    private lazy var missedGoalsLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .systemFont(ofSize: 60)
        return label
    } ()
    
    private lazy var finalResultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 50)
        return label
    }()
    
    private lazy var scoreStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        return stack
    } ()
    
    private lazy var buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .equalSpacing
        stack.backgroundColor = .clear
        return stack
    } ()
    
    private lazy var mainUIStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 50
        stack.distribution = .fill
        return stack
    } ()
    
    private lazy var muLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mu2"))
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    } ()
    
    private lazy var barcaLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "barcaLogo"))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    } ()
    
    private var scoredGoals = 0
    private var missedGoals = 0
    
    override func viewDidLoad() {
        setUpUIElements()
    
    }
}

extension MainVC {
    
    private func setUpUIElements() {
        setUpButtonsStack()
        setUpScoreStack()
        setUpFinalResults()
        setUpContstraints()
    }
    
    private func setUpContstraints() {
        
        mainUIStack.addArrangedSubview(scoreStackView)
        mainUIStack.addArrangedSubview(buttonsStackView)
        mainUIStack.addArrangedSubview(finalResultLabel)
        
        view.addSubview(mainUIStack)
        mainUIStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scoreStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreStackView.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            scoreStackView.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            finalResultLabel.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor),
            finalResultLabel.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor),
            finalResultLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 50)
        ])
    }
    
    private func showCorrectResult() {
        let result = scoredGoals - missedGoals
        switch result {
        case 1...: finalResultLabel.text = "We won the game"
        case ..<0: finalResultLabel.text = "We lost the game"
        default: finalResultLabel.text = "The game ended in a draw"
        }
    }
    
    private func setUpScoreStack() {
        
        let colon: UILabel = {
            let label = UILabel()
            label.text = ":"
            label.font = .systemFont(ofSize: 50)
            label.textColor = .white
            return label
        }()
        
        scoreStackView.addArrangedSubview(muLogo)
//        scoreStackView.addArrangedSubview(UIView())
        scoreStackView.addArrangedSubview(scoredGoalsLabel)
        scoreStackView.addArrangedSubview(colon)
        scoreStackView.addArrangedSubview(missedGoalsLabel)
//        scoreStackView.addArrangedSubview(UIView())
        scoreStackView.addArrangedSubview(barcaLogo)
        
        
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpButtonsStack() {
        
        buttonsStackView.addArrangedSubview(UIView())
        buttonsStackView.addArrangedSubview(plusButton)
        buttonsStackView.addArrangedSubview(minusButton)
        buttonsStackView.addArrangedSubview(UIView())
        
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setUpFinalResults() {
        finalResultLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func colorAnimation(color: CGColor, forw: UIImageView) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = UIColor.clear.cgColor
        animation.toValue = color
        animation.duration = 0.5
        animation.autoreverses = true
        animation.repeatCount = 1
        forw.layer.add(animation, forKey: nil)
    }
}

extension MainVC {
    
    @objc private func plusButtonDidTap(_ sender: UIButton) {
        scoredGoals += 1
        scoredGoalsLabel.text = "\(scoredGoals)"
        showCorrectResult()
        colorAnimation(color: UIColor.red.cgColor, forw: muLogo)
    }
    
    @objc private func minusButtonDidTap(_ sender: UIButton) {
        missedGoals += 1
        missedGoalsLabel.text = "\(missedGoals)"
        showCorrectResult()
        colorAnimation(color: UIColor.purple.cgColor, forw: barcaLogo)
    }
}
