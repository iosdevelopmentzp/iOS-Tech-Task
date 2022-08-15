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
        static let controlsMinSpace: CGFloat = 30
    }
    
    // MARK: - Properties
    
    public let viewModel: LoginViewModel
    
    private let keyboardListener = KeyboardListener()
    
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIControl()
    private let textFieldsContainer = UIView()
    private let logInButton = UIButton()
    private var logInButtonBottomConstraint: NSLayoutConstraint?
    private let loginTextField = TextField()
    private let passwordTextField = TextField()
    private let spacer = UIView()
    
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
        keyboardListener.delegate = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        keyboardListener.startListen()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        keyboardListener.stopListen()
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        handlerTrateCollectionChange(with: coordinator)
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
        
        stackView.axis = .vertical
    }
    
    public func setupLocalization() {
        logInButton.setTitle(Strings.Login.loginButtonTitle, for: .normal)
        loginTextField.placeholder = "Email"
        passwordTextField.placeholder = "Password"
    }
    
    public func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(textFieldsContainer)
        textFieldsContainer.addSubview(loginTextField)
        textFieldsContainer.addSubview(passwordTextField)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(logInButton)
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
        
        stackView.snp.makeConstraints {
            logInButtonBottomConstraint = $0.bottom
                .equalToSuperview()
                .inset(Constants.loginButtonBottomPadding)
                .constraint
                .layoutConstraints
                .first
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
        }
        
        logInButton.snp.makeConstraints {
            $0.height.equalTo(44)
        }
        
        textFieldsContainer.snp.makeConstraints {
            $0.centerX.equalTo(self.contentView)
            $0.centerY.equalTo(self.contentView).priority(.medium)
        }
        
        loginTextField.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.height.equalTo(44)
            $0.top.equalTo(self.loginTextField.snp.bottom).offset(Constants.controlsMinSpace)
        }
        
        spacer.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(Constants.controlsMinSpace)
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

// MARK: - Keyboard Actions

extension LoginViewController: KeyboardListenerDelegate {
    // MARK: - KeyboardListenerDelegate
    
    public func keyboardFrameWillChange(listener: KeyboardListener, newFrame: CGRect) {
        updateConstraints(for: newFrame)
        updateInset(for: newFrame)
    }
    
    // MARK: Private Keyboard Actions
    
    private func handlerTrateCollectionChange(with coordinator: UIViewControllerTransitionCoordinator) {
        guard keyboardListener.isKeyboardShowed(visibleViewController: self) else { return }
        keyboardListener.allowNotify = false
        updateInset(for: nil)
        updateConstraints(for: nil)

        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            DispatchQueue.main.async { [weak self] in
                guard let keyboardFrame = self?.keyboardListener.keyboardFrame else { return }
                self?.updateInset(for: keyboardFrame)
                self?.updateConstraints(for: keyboardFrame)
            }
            self?.keyboardListener.allowNotify = true
        }
    }
    
    private func updateInset(for keyboardFrame: CGRect?) {
        scrollView.contentInset = .init(
            top: 0,
            left: 0,
            bottom: keyboardFrame.map { max(0, scrollView.frame.maxY - $0.minY) } ?? 0 ,
            right: 0
        )
    }
    
    private func updateConstraints(for keyboardFrame: CGRect?) {
        guard let constraint = logInButtonBottomConstraint else { return }
        
        var newConstant = -Constants.loginButtonBottomPadding
        
        defer {
            if newConstant != constraint.constant {
                constraint.constant = newConstant
                UIView.animate(withDuration: 0.2) {
                    self.contentView.layoutIfNeeded()
                }
            }
        }
        
        guard let keyboardFrame = keyboardFrame, view.bounds.width < view.bounds.height else { return }
        
        let buttonFrame = self.logInButton.superview?.convert(self.logInButton.frame, to: self.view) ?? .zero
        let currentMinY = buttonFrame.minY
        let targetMinY = keyboardFrame.minY - Constants.loginButtonBottomPadding - buttonFrame.height
        let shift = targetMinY - currentMinY
        newConstant = min(-Constants.loginButtonBottomPadding, constraint.constant + shift)
    }
}
