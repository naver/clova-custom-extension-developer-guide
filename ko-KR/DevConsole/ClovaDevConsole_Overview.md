<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

<!-- Start of the shared content: DeveloperConsoleOverview -->

# CLOVA developer console 개요

[CLOVA developer console]({{ book.ServiceEnv.DeveloperConsoleURI }})은 CLOVA 플랫폼과 연동하는 기기나 서비스를 개발할 때 필요한 정보나 기능을 제공하는 웹 도구입니다. 클라이언트 개발자는 CLOVA developer console를 통해 개발하려는 클라이언트(기기 또는 앱)의 정보를 입력하고 해당 클라이언트가 CIC에 접속할 수 있도록 보안 정보를 설정합니다. Extension 개발자는 CEK와 extension이 메시지를 주고 받을 수 있도록 [extension 정보를 입력](/DevConsole/Guides/Register_Custom_Extension.md)하고, [interaction 모델을 등록](/DevConsole/Guides/Register_Interaction_Model.md)하게 됩니다. 뿐만 아니라 extension 개발자는 [extension 배포](/DevConsole/Guides/Deploy_Custom_Extension.md)를 위해 extension을 테스트하고 extension 심사도 신청해야 합니다.

클라이언트를 개발하거나 extension을 개발할 때 CLOVA developer console은 다음과 같은 구조로 사용됩니다.

![DevConsole-Concept_Diagram](/DevConsole/Assets/Images/DevConsole-Concept_Diagram.png)

위와 같이 CLOVA developer console을 통해 extension을 등록, 배포, 업데이트, 중지 및 삭제할 수 있습니다. 이 작업은 extension의 lifecyle과 관련이 있으며, CLOVA developer console에서 extension의 lifecycle은 다음 그림과 같습니다.

![DevConsole-Extension_LifeCycle](/DevConsole/Assets/Images/DevConsole-Extension_LifeCycle.png)

<!-- End of the shared content -->

CLOVA developer console의 CEK 메뉴를 통해 custom extension을 등록 및 관리할 수 있으며, [CEK](/Develop/CEK_Overview.md#WhatisCEK)와 연결하여 custom extension이나 interaction 모델을 테스트해볼 수 있습니다. 다음과 같이 왼쪽에 있는 **CLOVA Extensions Kit β** 메뉴나 중앙에 있는 바(bar) 형태의 메뉴를 누르면 CEK 메뉴로 진입합니다.

![DevConsole-Entering_CEK_Menu](/DevConsole/Assets/Images/DevConsole-Entering_CEK_Menu.png)

CEK 메뉴를 통해 다음과 같은 작업을 처리할 수 있습니다.

* [Custom extension 등록하기](/DevConsole/Guides/Register_Custom_Extension.md)
* [Interaction 모델 등록하기](/DevConsole/Guides/Register_Interaction_Model.md)
* [Custom extension 테스트하기](/DevConsole/Guides/Test_Custom_Extension.md)
* [Custom extension 배포하기](/DevConsole/Guides/Deploy_Custom_Extension.md)
* [Custom extension 업데이트하기](/DevConsole/Guides/Update_Custom_Extension.md)
* [Custom extension 중지 및 삭제하기](/DevConsole/Guides/Remove_Custom_Extension.md)
