//
//  ContainerNode.swift
//  TextureExam
//
//  Created by 조상호 on 2021/06/04.
//

import Foundation
import AsyncDisplayKit

class ContainerNode: ASDisplayNode {

  // MARK: 선언부
  let contentsNode = ContentsNode()
}

  // MARK: 구현부

extension ContainerNode {
  override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
    ASInsetLayoutSpec(insets: .init(top: self.safeAreaInsets.top, left: 0, bottom: self.safeAreaInsets.bottom, right: 0), child: contentsNode)
  }
}
