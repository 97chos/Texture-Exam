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

//  private lazy var verticalLayoutNode1: ASLayoutSpec = {
//    let layout = ASStackLayoutSpec()
//    layout.direction = .horizontal
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
    paragraphStyle.alignment = .center
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
  private let backgroundNode = ASDisplayNode()


  // MARK: Initializing

  override init() {
    super.init(node: ASDisplayNode())
    self.node.backgroundColor = .systemGray6
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
    let contentLayout = ASStackLayoutSpec(
      direction: .vertical,
      spacing: .zero,
      justifyContent: .start,
      alignItems: .stretch,
      children: [
        contentAreaLayoutSpec(),
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 }
      ])

    return ASInsetLayoutSpec(insets: self.node.safeAreaInsets,
                             child: contentLayout)
  }

  private func contentAreaLayoutSpec() -> ASLayoutSpec {
    let contentLayout = ASStackLayoutSpec(direction: .vertical,
                             spacing: 10.0,
                             justifyContent: .start,
                             alignItems: .stretch,
                             children: [
                              imageAreaLayoutSpec(),
                              titleLayoutSpec()
                             ])

    backgroundNode.backgroundColor = .red

    let containerLayout = ASInsetLayoutSpec(insets: .init(top: 0, left: 0, bottom: 0, right: 0), child: contentLayout)
    return ASBackgroundLayoutSpec(child: containerLayout, background: backgroundNode)
  }

  private func imageAreaLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 },
        ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
          $0.maxWidth = .init(unit: .points, value: 300)
        },
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 }
      ])
  }

  private func titleLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        ASLayoutSpec().styled{ $0.flexShrink = 1.0},
        titleNode,
        ASLayoutSpec().styled{ $0.flexShrink = 1.0}
      ])
  }
}

