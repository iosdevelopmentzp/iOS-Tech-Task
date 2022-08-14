//
//  LoginViewController.swift
//  
//
//  Created by Dmytro Vorko on 08.08.2022.
//

import Foundation
import AppResources
import UIKit
import MVVM
import Extensions
import SnapKit
import AppViews

public final class LoginViewController: UIViewController, View, ViewSettableType, KeyboardNotifiable {
    // MARK: - Nested
    
    private struct Constants {
        static let loginButtonBottomPadding: CGFloat = 20
    }
    
    // MARK: - Properties
    
    public let viewModel: LoginViewModel
    
    private let scrollView = UIScrollView()
    private let contentView = UIControl()
    private let textFieldsContainer = UIView()
    private let logInButton = UIButton()
    private var logInButtonBottomConstraint: NSLayoutConstraint?
    private let loginTextField = TextField()
    private let passwordTextField = TextField()
    
    // MARK: - Constructor
    
    public init(_ viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        performSetupViews()
        setupOutput()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        registerKeyboardNotification(.willChangeFrame) { [weak self] notification in
            notification.keyboardFrame.map {
                self?.updateConstraints(for: $0)
                self?.updateInset(for: $0)
            }
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        deregisterKeyboardNotification(self, type: .willChangeFrame)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Setup
    
    public func setupViews() {
        logInButton.titleLabel?.font = Fonts.Lato.bold.font(size: 20)
        logInButton.backgroundColor = Colors.Buttons.blue.color
        logInButton.layer.cornerRadius = 8
        
        scrollView.bounces = true
        
        loginTextField.layer.borderColor = Colors.Border.black.color.cgColor
        loginTextField.layer.borderWidth = 1
        loginTextField.layer.cornerRadius = 6
        
        passwordTextField.layer.borderColor = Colors.Border.black.color.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.cornerRadius = 6
        
        contentView.addTarget(self, action: #selector(self.didTapContent(_:)), for: .touchUpInside)
    }
    
    public func setupLocalization() {
        logInButton.setTitle(Strings.Login.loginButtonTitle, for: .normal)
        loginTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    public func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(logInButton)
        contentView.addSubview(textFieldsContainer)
        textFieldsContainer.addSubview(loginTextField)
        textFieldsContainer.addSubview(passwordTextField)
    }
    
    public func layoutViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        logInButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalTo(44)
            logInButtonBottomConstraint = $0.bottom
                .equalToSuperview()
                .inset(Constants.loginButtonBottomPadding)
                .constraint
                .layoutConstraints
                .first
        }
        
        textFieldsContainer.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().priority(.medium)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.bottom.lessThanOrEqualTo(self.logInButton.snp.top).offset(-30)
        }
        
        loginTextField.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44)
            $0.top.equalTo(self.loginTextField.snp.bottom).offset(30)
        }
    }
    
    public func setupOutput() {
        viewModel.transform(.init(), outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: LoginViewModel.Output) {
        
    }
    
    // MARK: - User Interaction
    
    @objc
    private func didTapContent(_ sender: UIControl) {
        self.view.endEditing(true)
    }
}

// MARK: - Private Functions

private extension LoginViewController {
    private func updateInset(for keyboardFrame: CGRect) {
        scrollView.contentInset = .init(
            top: 0,
            left: 0,
            bottom: max(0, scrollView.frame.maxY - keyboardFrame.minY),
            right: 0
        )
    }
    
    private func updateConstraints(for keyboardFrame: CGRect) {
        guard let constraint = logInButtonBottomConstraint else { return }
        
        let buttonFrame = self.logInButton.superview?.convert(self.logInButton.frame, to: self.view) ?? .zero
        let currentMinY = buttonFrame.minY
        let targetMinY = keyboardFrame.minY - Constants.loginButtonBottomPadding - buttonFrame.height
        let shift = targetMinY - currentMinY
        constraint.constant = min(-Constants.loginButtonBottomPadding, constraint.constant + shift)
        
        UIView.animate(withDuration: 0.2) {
            self.contentView.layoutIfNeeded()
        }
    }
}
