//
//  ViewController.swift
//  TextureExam
//
//  Created by 조상호 on 2021/06/02.
//

import UIKit
import AsyncDisplayKit
import TextureSwiftSupport

class ViewController: ASDKViewController<ContainerNode> {

  // MARK: Initializing

  override init() {
    super.init(node: .init())
    self.title = "버전확인"

    self.node.backgroundColor = .systemGray6
    self.node.automaticallyManagesSubnodes = true
    self.node.automaticallyRelayoutOnSafeAreaChanges = true
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
