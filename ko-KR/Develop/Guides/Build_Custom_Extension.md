# Custom extension 만들기

Custom extension이란 CLOVA가 기본으로 제공하고 있는 기능이나 서비스가 아닌 개발자가 임의로 확장한 기능이나 외부 서비스를 제공해주는 extension입니다. 예를 들면, 웹 검색, 뉴스 클리핑과 같은 서비스 뿐만 사용자 계정의 인증이 필요한 음악, 쇼핑, 금융 서비스와 같은 외부 서비스를 제공하는 extension입니다. Custom extension은 CLOVA로부터 분석된 사용자의 발화 정보를 전달받게 되며, 이에 상응하는 내용을 처리하고 그 서비스 처리 결과를 반환해야 합니다.

이 절에서는 Custom extension을 만들기 위해 사전에 준비해야 할 것이 무엇이 있고 CLOVA와 어떤 메시지를 주고 받으면서 어떻게 동작을 수행해야 하는지 다음과 같은 내용을 설명합니다.

* [사전 준비사항](#Preparation)
* [Custom extension 요청 처리하기](#HandleCustomExtensionRequest)
   * [`LaunchRequest` 요청 처리](#HandleLaunchRequest)
   * [`IntentRequest` 요청 처리](#HandleIntentRequest)
   * [`SessionEndedRequest` 요청 처리](#HandleSessionEndedRequest)
   * [요청 메시지 검증](#RequestMessageValidation)
* [Custom extension 응답 반환하기](#ReturnCustomExtensionResponse)

{% include "/Develop/Guides/BuildCustomExtension/Preparation.md" %}

{% include "/Develop/Guides/BuildCustomExtension/Handle_Custom_Extension_Request.md" %}

{% include "/Develop/Guides/BuildCustomExtension/Validating_Request_Message.md" %}

{% include "/Develop/Guides/BuildCustomExtension/Return_Custom_Extension_Response.md" %}
