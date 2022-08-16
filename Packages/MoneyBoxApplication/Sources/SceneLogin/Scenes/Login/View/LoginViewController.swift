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
    
    private enum Event {
        case loginTap
        case loginTextDidChange(_ text: String)
        case passwordTextDidChange(_ text: String)
    }
    
    // MARK: - Properties
    
    public let viewModel: LoginViewModel
    
    private let keyboardListener = KeyboardListener()
    
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()
    private let contentView = UIControl()
    private let textFieldsContainer = UIView()
    private let logInButton = LoginButton()
    private var logInButtonBottomConstraint: NSLayoutConstraint?
    private let loginTextField = LoginTextField(mode: .email)
    private let passwordTextField = LoginTextField(mode: .password)
    private let spacer = UIView()
    
    private var eventsHandler: ArgClosure<Event, Void>?
    
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
        scrollView.bounces = false
        stackView.axis = .vertical
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
        
        textFieldsContainer.snp.makeConstraints {
            $0.centerX.equalTo(self.contentView)
            $0.centerY.equalTo(self.contentView).priority(.medium)
        }
        
        loginTextField.snp.makeConstraints {
            $0.left.top.right.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.left.bottom.right.equalToSuperview()
            $0.top.equalTo(self.loginTextField.snp.bottom).offset(Constants.controlsMinSpace)
        }
        
        spacer.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(Constants.controlsMinSpace)
        }
    }
    
    public func setupViewLinks() {
        contentView.addTarget(self, action: #selector(self.didTapContent(_:)), for: .touchUpInside)
        
        logInButton.delegate = self
        loginTextField.eventsDelegate = self
        passwordTextField.eventsDelegate = self
        
    }
    
    public func setupOutput() {
        let output = LoginViewModel.Input(
            onStateUpdate: { [weak self] in self?.updateState($0.current, previous: $0.previous) }
        )
        
        viewModel.transform(output, outputHandler: self.setupInput(_:))
    }
    
    public func setupInput(_ input: LoginViewModel.Output) {
        eventsHandler = {
            switch $0 {
            case .loginTap:
                input.onEvent(.loginTap)
                
            case .loginTextDidChange(let loginText):
                input.onEvent(.loginText(loginText))
                
            case .passwordTextDidChange(let password):
                input.onEvent(.passwordText(password))
            }
        }
    }
    
    // MARK: - User Interaction
    
    @objc
    private func didTapContent(_ sender: UIControl) {
        self.view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func updateState(_ state: LoginState, previous: LoginState?) {
//        view.isUserInteractionEnabled = state.isLoading == false
        
        if state.isLoading != previous?.isLoading {
            logInButton.setActivityIndicator(isAnimating: state.isLoading)
        }
        
        if let errorMessage = state.errorMessage {
            // TODO: - Handler error
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
        }
        
        guard let models = state.model, models != previous?.model else { return }
        loginTextField.configure(using: models.loginTextFieldModel)
        passwordTextField.configure(using: models.passwordTextFieldModel)
        logInButton.configure(using: models.loginButtonModel)
    }
}

// MARK: - LoginButtonDelegate

extension LoginViewController: LoginButtonDelegate {
    func didTap(button: LoginButton) {
        eventsHandler?(.loginTap)
    }
}

// MARK: - LoginTextFieldEventsDelegate

extension LoginViewController: LoginTextFieldEventsDelegate {
    func didChangeText(textField: LoginTextField, text: String?) {
        switch textField {
        case loginTextField:
            eventsHandler?(.loginTextDidChange(text ?? ""))
            
        case passwordTextField:
            eventsHandler?(.passwordTextDidChange(text ?? ""))
            
        default:
            assertionFailure("Unexpected text field")
            break
        }
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
            // Update keyboard spaces after animation was finished
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
