//
//  ViewController.swift
//  TextureExam
//
//  Created by 조상호 on 2021/06/02.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASDKViewController<ASDisplayNode> {

  // MARK: UI

//  private let verticalLayoutNode1: ASLayoutSize = {
//
//  }()
//  private let verticalLayoutNode2: ASLayoutSize = {
//
//  }()
//  private let verticalLayoutNode3: ASLayoutSize = {
//
//  }()
//  private let horizontalImageNode1: ASLayoutSize = {
//
//  }()
//  private let horizontalImageNode2: ASLayoutSize = {
//
//  }()
//  private let virticalTitleNode: ASLayoutSize = {
//
//  }()

  private let imageNode: ASImageNode = {
    let node = ASImageNode()
    node.image = UIImage(named: "flitto")
    node.cornerRadius = 10
    return node
  }()
  private let titleNode: ASTextNode = {
    let node = ASTextNode()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .left
    node.attributedText = NSAttributedString(
      string: "현재 최신 버전을 이용 중입니다.",
      attributes: [
        .font: UIFont.boldSystemFont(ofSize: 15.0),
        .foregroundColor: UIColor.gray,
        .paragraphStyle: paragraphStyle
      ]
    )
    return node
  }()


  // MARK: Initializing

  override init() {
    super.init(node: ASDisplayNode())
    self.node.backgroundColor = .white
    self.node.automaticallyManagesSubnodes = true
    self.node.automaticallyRelayoutOnSafeAreaChanges = true
    self.node.layoutSpecBlock = { [weak self] (node, constraintedSize) -> ASLayoutSpec in
      return self?.layoutSpecThatFits(constraintedSize) ?? ASLayoutSpec()
    }
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }


  // MARK: Layout

  private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {
    var containerInsets: UIEdgeInsets = self.node.safeAreaInsets
    return ASInsetLayoutSpec(insets: containerInsets,
                             child: self.contentLayoutSpec())
  }

  private func contentLayoutSpec() -> ASLayoutSpec {
    return ASStackLayoutSpec(direction: .vertical,
                             spacing: 10.0,
                             justifyContent: .center,
                             alignItems: .center,
                             children: [self.imageLayoutSpec(), self.titleNode])
  }

  private func imageLayoutSpec() -> ASLayoutSpec {
    return ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
      $0.flexShrink = 1.0
      $0.maxWidth = .init(unit: .points, value: 300)
    }
  }

}

