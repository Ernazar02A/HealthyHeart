//
//  
//  UserInformationFormViewController.swift
//  HealthyHeart
//
//  Created by Ernazar on 27/6/24.
//
//

import UIKit
import SnapKit

struct InputModel {
    let title: String
    var text: String
    let placeholder: String
    let isEnable: Bool
    let keyboardType: UIKeyboardType
}

protocol UserInformationFormScreen: AnyObject {
    var presenter: IUserInformationFormPresenter! { get set }
}

typealias IUserInformationFormViewController = BaseViewController & UserInformationFormScreen

final class UserInformationFormViewController: IUserInformationFormViewController {
    
    private lazy var inputTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(cell: InputTableViewCell.self)
        view.delegate = self
        view.dataSource = self
        view.tableHeaderView = InputHeaderView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 150))
        return view
    }()
    
    private lazy var calendar: UICalendarView = {
        let view = UICalendarView()
        view.layer.cornerRadius = 10
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        view.selectionBehavior = dateSelection
        view.locale = Locale(identifier: "ru_RU")
        view.isHidden = true
        return view
    }()
    
    private let continueButton = MainButton(isActive: true)
    
    private var inputs: [InputModel] = [
        .init(
            title: "Имя",
            text: "",
            placeholder: "Введите",
            isEnable: true,
            keyboardType: .namePhonePad
        ),
        .init(
            title: "Фамилия",
            text: "",
            placeholder: "Введите",
            isEnable: true,
            keyboardType: .namePhonePad
        ),
        .init(
            title: "Дата рождения",
            text: "",
            placeholder: "Выбрать",
            isEnable: false,
            keyboardType: .numberPad
        ),
        .init(
            title: "Пол",
            text: "",
            placeholder: "Введите",
            isEnable: false,
            keyboardType: .default
        ),
        .init(
            title: "Рост (cм)",
            text: "",
            placeholder: "Введите",
            isEnable: true,
            keyboardType: .numberPad),
        .init(
            title: "Вес (кг)",
            text: "",
            placeholder: "Введите",
            isEnable: true,
            keyboardType: .numberPad
        ),
    ]
    
    var presenter: IUserInformationFormPresenter!
    
    override func setup() {
        super.setup()
        presenter.setDelegate(self)
        continueButton.addTarget(self, action: #selector(countinueTapped), for: .touchUpInside)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        view.add {
            inputTableView
            continueButton
            calendar
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        inputTableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
            make.height.equalTo(500)
        }
        calendar.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.height.equalTo(350)
        }
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(inputTableView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(widthComputed(24))
            make.height.equalTo(50)
        }
    }
    
    override func applyThemeProperties(_ themeProperties: any ThemeProperties) {
        super.applyThemeProperties(themeProperties)
        view.backgroundColor = themeProperties.bgPrimary
        inputTableView.backgroundColor = themeProperties.bgPrimary
        calendar.tintColor = themeProperties.blue
        calendar.backgroundColor = themeProperties.bgGray
    }
    
    override func applyLocalization() {
        super.applyLocalization()
        continueButton.setTitle("Продолжит", for: .normal)
    }
    
    @objc
    private func countinueTapped(_ sender: UIButton) {
        sender.animationTapButton()
        guard
            !inputs[0].text.isEmpty,
            !inputs[1].text.isEmpty,
            !inputs[3].text.isEmpty,
            !inputs[4].text.isEmpty,
            !inputs[5].text.isEmpty else {
            emtyError()
            return
        }
        let nameText = inputs[0].text
        let surenameText = inputs[1].text
        let maleText = inputs[3].text
        let heightText = inputs[4].text
        let weightText = inputs[5].text
        presenter.countinue(model: .init(firstName: nameText, lastName: surenameText, dateOfBirth: "", gender: maleText, height: Int(heightText) ?? 0, weight: weightText))
    }
    
    private func emtyError() {
        let alert = UIAlertController(title: "Заполните все поля", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Хорошо", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

//MARK: - IUserInformationFormDelegate
extension UserInformationFormViewController: IUserInformationFormDelegate {
    
}

//MARK: - UITableViewDataSource
extension UserInformationFormViewController: UITableViewDataSource {
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return inputs.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.getCell(
            for: indexPath,
            with: InputTableViewCell.self
        )
        let input = inputs[indexPath.row]
        cell.fill(with: input, index: indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITableViewDelegate
extension UserInformationFormViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 2:
            calendar.isHidden = false
        case 3:
            let alert = UIAlertController(title: "Выберите ваш пол", message: nil, preferredStyle: .actionSheet)
            let actionMan = UIAlertAction(title: "Мужчина", style: .default) { [weak self]_ in
                guard let self else { return }
                self.inputs[3].text = "Мужчина"
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            let actionWomen = UIAlertAction(title: "Женщина", style: .default) { [weak self]_ in
                guard let self else { return }
                self.inputs[3].text = "Женщина"
                tableView.reloadRows(at: [indexPath], with: .none)
            }
            alert.addAction(actionMan)
            alert.addAction(actionWomen)
            present(alert, animated: true)
        default: break
        }
    }
}

//MARK: - UICalendarSelectionSingleDateDelegate
extension UserInformationFormViewController: UICalendarSelectionSingleDateDelegate {
    
    func dateSelection(
        _ selection: UICalendarSelectionSingleDate,
        didSelectDate dateComponents: DateComponents?
    ) {
        guard let dateComponents = dateComponents else { return }
        let calendar = Calendar.current
        if let selectedDate = calendar.date(from: dateComponents) {
            inputs[2].text = selectedDate.fullDateString
            presenter.setDate(date: selectedDate)
            inputTableView.reloadRows(at: [.init(row: 2, section: 0)], with: .none)
            self.calendar.isHidden = true
        }
    }
}

//MARK: - InputTableViewCellDelegate
extension UserInformationFormViewController: InputTableViewCellDelegate {
    
    func setText(index: Int, text: String) {
        switch index {
        case 0, 1, 4, 5:
            inputs[index].text = text
        default: break
        }
    }
}
