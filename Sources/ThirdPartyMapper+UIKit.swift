//
//  ThirdPartyMapper+UIKit.swift
//  ThirdPartyMapper
//
//  Created by Zsolt Kovacs on 01.08.23.
//

import UIKit

extension ThirdPartyMapper {
    public class func open(searchQuery: String, isAddress: Bool, on viewController: UIViewController) {
        let clientsWithURL = filterClients(searchQuery: searchQuery, isAddress: isAddress)

        if clientsWithURL.count == 1 {
            let client = clientsWithURL.first!
            UIApplication.shared.open(client.url)
        } else {
            let alert = buildAlert(from: clientsWithURL)
            viewController.present(alert, animated: true)
        }
    }

    private class func buildAlert(from clientsWithURL: [ClientWithURL]) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let actions = clientsWithURL.map { (client, url) in
            UIAlertAction(title: client.name, style: .default) { _ in
                UIApplication.shared.open(url)
            }
        }

        actions.forEach { alert.addAction($0) }

        let cancel = UIAlertAction(
            title: Bundle(for: UIButton.self).localizedString(forKey: "Cancel", value: "Cancel", table: ""),
            style: .cancel
        )

        alert.addAction(cancel)

        return alert
    }
}
