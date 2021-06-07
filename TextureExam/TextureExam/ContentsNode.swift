//
//  ContentsNode.swift
//  TextureExam
//
//  Created by 조상호 on 2021/06/04.
//

import Foundation
import AsyncDisplayKit
import TextureSwiftSupport

final class ContentsNode: ASScrollNode {

  // MARK: 선언부 (Definition)

  private enum Const {
    static let cornerRadius: CGFloat = 10
    static let boldFontSize: CGFloat = 17
    static let fontSize: CGFloat = 15
    static let spacing: CGFloat = 20
    static let borderWidth: CGFloat = 1
    static let minSpacing: CGFloat = 70
    static let minButtonSize: CGSize = .init(width: 200, height: 50)
    static let imageWidth: CGFloat = 100
  }

  private let imageNode = ASImageNode()
  private let titleNode = ASTextNode()
  private let subTitleNode = ASTextNode()
  private let buttonNode = ASButtonNode()
  private let backgroundNode = ASDisplayNode()

  override init() {
    defer {
      self.automaticallyManagesContentSize = true
      self.automaticallyManagesSubnodes = true
    }
    super.init()
    weak var `self` = self
    applyNode().forEach { $0(self) }
  }
}


// MARK: Set Node

extension ContentsNode {

  typealias apply = ((ContentsNode?) -> ())

  @discardableResult
  func applyNode() -> [apply] {
    [
      {
        $0?.imageNode.image = UIImage(named: "flitto")
        $0?.imageNode.cornerRadius = Const.cornerRadius
      },
      {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        $0?.titleNode.attributedText = NSAttributedString(
          string: "현재 최신 버전을 이용 중입니다.",
          attributes: [
            .font: UIFont.boldSystemFont(ofSize: Const.boldFontSize),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
          ]
        )
      },
      {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        $0?.subTitleNode.attributedText = NSAttributedString(
          string: "현재 버전 21.06.01",
          attributes: [
            .font: UIFont.systemFont(ofSize: Const.fontSize),
            .paragraphStyle: paragraphStyle
          ])
      },
      {
        let title = NSAttributedString(string: "최신 버전 업데이트",
                                       attributes: [
                                        .font : UIFont.boldSystemFont(ofSize: Const.fontSize),
                                        .foregroundColor : UIColor.systemGray
        ])
        $0?.buttonNode.setAttributedTitle(title, for: .normal)
        $0?.buttonNode.cornerRadius = Const.cornerRadius
        $0?.buttonNode.borderWidth = Const.borderWidth
        $0?.buttonNode.borderColor = UIColor.systemGray.cgColor
      },
      {
        $0?.backgroundNode.backgroundColor = .white
      }
    ]
  }

//  private func applyImageNode() {
//    self.imageNode.image = UIImage(named: "flitto")
//    self.imageNode.cornerRadius = const.cornerRadius
//  }
//
//  private func applyTitleNode() {
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.alignment = .center
//    self.titleNode.attributedText = NSAttributedString(
//      string: "현재 최신 버전을 이용 중입니다.",
//      attributes: [
//        .font: UIFont.boldSystemFont(ofSize: const.boldFontSize),
//        .foregroundColor: UIColor.black,
//        .paragraphStyle: paragraphStyle
//      ]
//    )
//  }
//
//  private func applySubTitleNode() {
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.alignment = .center
//    self.subTitleNode.attributedText = NSAttributedString(
//      string: "현재 버전 21.06.01",
//      attributes: [
//        .font: UIFont.systemFont(ofSize: const.fontSize),
//        .paragraphStyle: paragraphStyle
//      ])
//  }

//  private func applyButtonNode() {
//    let title = NSAttributedString(string: "최신 버전 업데이트",
//                                   attributes: [
//                                    .font : UIFont.boldSystemFont(ofSize: const.fontSize),
//                                    .foregroundColor : UIColor.systemGray
//    ])
//    self.buttonNode.setAttributedTitle(title, for: .normal)
//    self.buttonNode.cornerRadius = const.cornerRadius
//    self.buttonNode.borderWidth = const.borderWidth
//    self.buttonNode.borderColor = UIColor.systemGray.cgColor
//  }
//
//  private func applyBackgroundNode() {
//    self.backgroundNode.backgroundColor = .white
//  }
}


// MARK: LayoutSpec

extension ContentsNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    LayoutSpec { [weak self] in
      VStackLayout {
        VStackLayout(alignItems: .center) {
          ASLayoutSpec()
            .minHeight(Const.minSpacing)
          self?.imageNode
            .aspectRatio(1.0)
            .maxWidth(Const.imageWidth)
            .padding(.bottom, Const.spacing)
          self?.titleNode
          self?.subTitleNode
            .padding(.bottom, Const.spacing)
          self?.buttonNode
            .minSize(Const.minButtonSize)
          ASLayoutSpec()
            .minHeight(Const.minSpacing)
        }
        .background(self?.backgroundNode)

        ASLayoutSpec()
          .flexShrink(1.0)
      }
    }
//    ASStackLayoutSpec(
//      direction: .vertical,
//      spacing: 0,
//      justifyContent: .start,
//      alignItems: .stretch,
//      children: [
//        contentsAreaLayoutSpec(),
//        ASLayoutSpec().styled{
//          $0.minHeight = .init(unit: .points, value: 0)
//          $0.flexShrink = 1.0
//        }
//      ])
  }
}


// MARK: Set Layout

//extension ContentsNode {
//  private func contentsAreaLayoutSpec() -> ASLayoutSpec {
//    LayoutSpec { [weak self] in
//      VStackLayout(alignItems: .center) {
//        self?.imageNode
//          .aspectRatio(1.0)
//          .maxWidth(Const.imageWidth)
//          .padding(.bottom, Const.spacing)
//        self?.titleNode
//        self?.subTitleNode
//          .padding(.bottom, Const.spacing)
//        self?.buttonNode
//          .minSize(Const.minButtonSize)
//      }}
//
//    let contentLayout = ASStackLayoutSpec(
//      direction: .vertical,
//      spacing: .zero,
//      justifyContent: .start,
//      alignItems: .center,
//      children: [
//        ASRatioLayoutSpec(ratio: 1.0, child: self.imageNode).styled {
//          $0.maxWidth = .init(unit: .points, value: 100)
//        },
//        ASLayoutSpec().styled{ $0.minHeight = .init(unit: .points, value: const.spacing) },
//        titleNode,
//        subTitleNode,
//        ASLayoutSpec().styled{ $0.minHeight = .init(unit: .points, value: const.spacing) },
//        ASWrapperLayoutSpec(layoutElement: self.buttonNode).styled {
//          $0.minSize = .init(width: 200, height: 50)
//        }
//      ])
//
//    let contentsLayout = ASInsetLayoutSpec(insets: .init(top: 70, left: 0, bottom: 70, right: 0), child: contentLayout)
//    return ASBackgroundLayoutSpec(child: contentsLayout, background: backgroundNode)
//  }
//}
