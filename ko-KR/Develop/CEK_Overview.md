<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

<!-- Start of the shared content: CEKOverview -->

# CEK 개요
이 문서는 CLOVA Extensions Kit(이하 CEK)에 대해 자세히 설명합니다. 이 문서를 통해 CEK가 무엇이고 어떻게 동작하는지 파악할 수 있으며, CEK와 관련된 가이드나 레퍼런스를 제공합니다.

## CEK란? {#WhatisCEK}
CEK는 CLOVA와 CLOVA extension(이하 extension) 사이의 커뮤니케이션을 지원하는 플랫폼으로 extension을 개발 및 배포할 때 필요한 도구와 인터페이스를 제공합니다. 음악, 쇼핑, 금융 같은 외부 서비스(3rd party service)나 집 안 IoT 기기의 원격 제어와 같이 사용자가 CLOVA를 통해 더 많은 서비스와 기능을 경험할 수 있도록 CLOVA에 확장된 기능을 제공하는 애플리케이션입니다.

![CEK_Concept_Diagram](/Develop/Assets/Images/CEK_Concept_Diagram.png)

## CEK 구성 및 동작 구조 {#CEKComponentsAndOperationStructure}

CEK는 [CLOVA developer console](/DevConsole/ClovaDevConsole_Overview.md)과 CLOVA 자연어 이해 엔진을 제공합니다. CLOVA developer console은 extension을 생성, 테스트, 배포하거나 interaction model을 등록할 수 있도록 UI를 제공하며, CLOVA 자연어 이해 엔진은 등록된 interaction model을 이용하여 사용자의 발화를 분석하고 그 결과를 extension에 전달합니다.

Interaction model과, extension을 등록은 서비스 배포 전에 수행되어야 합니다. 배포 후 실행 시점에 CLOVA는 사용자의 발화를 인식하며, CEK를 통해 미리 등록된 [등록된 interaction 모델](/DevConsole/Guides/Register_Interaction_Model.md)을 참조하여 사용자의 발화를 분석합니다. CLOVA는 분석된 사용자의 발화 정보를 extension에 전달하며, extension은 사용자 요청에 대한 처리 결과를 응답으로 돌려줘야 합니다. 다음은 CEK의 동작 구조를 나타낸 다이어그램입니다.

![CEK_Components_And_Operation_Structure](/Develop/Assets/Images/CEK_Components_And_Operation_Structure.png)

다음은 각 구성 요소 사이에 어떤 요청과 응답이 오가는지를 중점적으로 나타낸 다이어그램입니다.

![CEK_Interaction_Structure](/Develop/Assets/Images/CEK_Interaction_Structure.png)


## Extension 종류 {#ExtensionType}
CLOVA 플랫폼은 다음과 같은 두 종류의 extension을 지원 및 제공하고 있습니다.

* [Custom extension](/Develop/Guides/Build_Custom_Extension.md): 임의의 확장된 기능을 제공하는 extension입니다. Custom extension을 사용하면 음악, 쇼핑, 금융과 같은 외부 서비스의 기능을 제공할 수 있습니다.
* [CLOVA Home extension]({{ book.DocMeta.CLOVAHomeExtensionDeveloperGuideBaseURI }}/Develop/Guides/Build_Clova_Home_Extension.{{ book.DocMeta.FileExtensionForExternalLink }}): IoT 기기 제어 서비스를 제공하기 위한 extension입니다.

<!-- End of the shared content -->
