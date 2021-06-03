//
//  ViewController.swift
//  TextureExam
//
//  Created by 조상호 on 2021/06/02.
//

import UIKit
import AsyncDisplayKit

class ViewController: ASDKViewController<ASDisplayNode> {

  enum const {
    static let cornerRadius: CGFloat = 10
    static let boldFontSize: CGFloat = 17
    static let fontSize: CGFloat = 15
  }

  // MARK: UI

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
        .font: UIFont.boldSystemFont(ofSize: const.boldFontSize),
        .foregroundColor: UIColor.black,
        .paragraphStyle: paragraphStyle
      ]
    )
    return node
  }()
  private let subTitleNode: ASTextNode = {
    let node = ASTextNode()
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.alignment = .center
    node.attributedText = NSAttributedString(
      string: "현재 버전 21.06.01",
      attributes: [
        .font: UIFont.systemFont(ofSize: const.fontSize),
        .paragraphStyle: paragraphStyle
      ])
    return node
  }()
  private let buttonNode: ASButtonNode = {
    let node = ASButtonNode()
    let title = NSAttributedString(string: "최신 버전 업데이트",
                                   attributes: [
                                    .font : UIFont.boldSystemFont(ofSize: const.fontSize),
                                    .foregroundColor : UIColor.systemGray
    ])
    node.setAttributedTitle(title, for: .normal)
    node.contentVerticalAlignment = .center
    node.contentHorizontalAlignment = .middle
    node.cornerRadius = const.cornerRadius
    node.borderWidth = 1
    node.borderColor = UIColor.systemGray.cgColor
    return node
  }()


  // MARK: Initializing

  override init() {
    super.init(node: ASDisplayNode())
    self.title = "버전확인"

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
                             spacing: 20.0,
                             justifyContent: .start,
                             alignItems: .stretch,
                             children: [
                              imageAreaLayoutSpec(),
                              titleWrapperLayoutSpec(),
                              ASLayoutSpec().styled{ $0.flexShrink = 1.0 },
                              buttonLayoutSpec()
                             ])

    let backgroundNode = ASDisplayNode()
    backgroundNode.backgroundColor = .white

    let containerLayout = ASInsetLayoutSpec(insets: .init(top: 70, left: 0, bottom: 70, right: 0), child: contentLayout)
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
          $0.maxWidth = .init(unit: .points, value: 100)
        },
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 }
      ])
  }

  private func titleWrapperLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .vertical,
      spacing: 0,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        titleLayoutSpec(),
        subtitleLayoutSec()
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

  private func subtitleLayoutSec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 },
        subTitleNode,
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 }
      ])
  }

  private func buttonLayoutSpec() -> ASLayoutSpec {
    ASStackLayoutSpec(
      direction: .horizontal,
      spacing: .zero,
      justifyContent: .spaceBetween,
      alignItems: .stretch,
      children: [
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 },
        ASWrapperLayoutSpec(layoutElement: self.buttonNode).styled {
          $0.minSize = .init(width: 200, height: 50)
        },
        ASLayoutSpec().styled{ $0.flexShrink = 1.0 }
      ])
  }
}

