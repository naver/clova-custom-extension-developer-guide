<!-- Note! This content includes shared parts. Therefore, when you update this file, you should beware of synchronization. -->

<!-- Start of the shared content: Glossary -->

# 용어 및 약어

<div class="note">
  <p><strong>Note!</strong></p>
  <p>이 페이지는 계속 업데이트되고 있습니다.</p>
</div>

<dl>
  <dt><strong>CEK</strong></dt>
  <dd><a href="#CEK">CLOVA Extensions Kit</a>의 약어</dd>
  <dt><strong>CIC</strong></dt>
  <dd><a href="#CIC">CLOVA Interface Connect</a>의 약어</dd>
  <dt id="CLOVA"><strong>CLOVA</strong></dt>
  <dd><a target="_blank" href="https://clova.ai">CLOVA</a>는 {{ book.ServiceEnv.OrientedService }}가 개발 및 서비스하고 있는 인공지능 플랫폼입니다. CLOVA 사용자의 음성이나 이미지를 인식하고 이를 분석하여 사용자가 원하는 정보나 서비스를 제공합니다. 3rd party 개발자는 CLOVA가 가진 기술을 활용하여 인공 지능 서비스를 제공하는 기기 또는 가전 제품을 만들거나 보유하고 있는 콘텐츠나 서비스를 CLOVA를 통해 사용자에게 제공할 수 있습니다.</dd>
  <dt id="CLOVADeveloperConsole"><strong>CLOVA developer console</strong></dt>
  <dd>CLOVA 플랫폼과 연동하는 클라이언트 기기나 <a href="#CLOVAExtension">CLOVA extension</a>을 개발하는 개발자에게 다음과 같은 내용을 제공하는 <a target="_blank" href="{{ book.ServiceEnv.DeveloperConsoleURI }}">웹 도구</a>입니다.
    <ul>
      <li>CLOVA extension <a href="/DevConsole/Guides/Register_Custom_Extension.md">등록</a> 및 <a href="/DevConsole/Guides/Deploy_Custom_Extension.md">배포</a></li>
      <li><a href="/DevConsole/Guides/Register_Interaction_Model.md">Interaction 모델 등록</a></li>
      <li>CLOVA 서비스 관련 통계 자료 제공 (추후 제공 예정)</li>
    </ul>
  </dd>
  <dt id="CLOVAExtension"><strong>CLOVA extension</strong></dt>
  <dd>음악, 쇼핑, 금융 같은 외부 서비스(3rd party service)나 집 안 IoT 기기의 원격 제어와 같이 사용자가 CLOVA를 통해 더 많은 서비스와 기능을 경험할 수 있도록 CLOVA에 확장된 기능을 제공하는 애플리케이션입니다. 짧게 extension이라 부르기도 하며, CLOVA 플랫폼은 현재 다음과 같은 두 종류의 extension을 지원공하고 있습니다. 일반 사용자에게는 "Skill"이라는 이름으로 제공되고 있습니다.
    <ul>
      <li><a href="#CustomExtension">Custom extension</a></li>
      <li><a href="#CLOVAHomeExtension">CLOVA Home extension</a></li>
    </ul>
  </dd>
  <dt id="CEK"><strong>CLOVA Extensions Kit (CEK)</strong></dt>
  <dd>CEK는 CLOVA와 <a href="/Develop/CEK_Overview.md">CLOVA extension(이하 extension) 사이의 커뮤니케이션</a>을 지원하는 플랫폼으로 extension을 개발 및 배포할 때 필요한 도구와 인터페이스를 제공합니다.</dd>
  <dt id="CLOVAHomeExtension"><strong>CLOVA Home extension</strong></dt>
  <dd>IoT 기기 제어 서비스를 제공하기 위한 <a href="#CLOVAExtension">extension</a>입니다. 자세한 내용은 <a href="{{ book.DocMeta.CLOVAHomeExtensionDeveloperGuideBaseURI }}/Develop/Guides/Build_Clova_Home_Extension.{{ book.DocMeta.FileExtensionForExternalLink}}">CLOVA Home extension 만들기</a> 문서를 참조합니다.</dd>
  <dt id="CIC"><strong>CLOVA Interface Connect (CIC)</strong></dt>
  <dd>인공 지능 비서 서비스를 제공하려는 PC/모바일용 앱, 모바일 또는 가전 기기의 클라이언트에 CLOVA와 연동할 수 있는 인터페이스를 제공하는 플랫폼입니다. 자세한 내용은 <a href="{{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/CIC_Overview.{{ book.DocMeta.FileExtensionForExternalLink }}">CIC 개요</a> 문서를 참조합니다.</dd>
  <dt id="CLOVAApp"><strong>CLOVA 앱</strong></dt>
  <dd>{{ book.ServiceEnv.OrientedService }}가 개발하여 iOS나 Android 플랫폼으로 배포한 CLOVA 앱입니다. CLOVA에 명령을 내릴 수 있을 뿐만 아니라 클라이언트 기기를 등록하고 관리할 수 있는 앱입니다.</dd>
  <dt id="ContentTemplate"><strong>Content template</strong></dt>
  <dd>CIC를 통해 전달되는 콘텐츠 정보를 일정 범주에 맞게 정형화한 것입니다. 자세한 내용은 <a href="{{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/Content_Templates.{{ book.DocMeta.FileExtensionForExternalLink }}">content template</a> 문서를 참조합니다.</dd>
  <dt id="CustomExtension"><strong>Custom extension</strong></dt>
  <dd>임의의 확장된 기능을 제공하는 <a href="#CLOVAExtension">extension</a>입니다. Custom extension을 사용하면 음악, 쇼핑, 금융과 같은 외부 서비스의 기능을 제공할 수 있습니다. 자세한 내용은 <a href="/Develop/Guides/Build_Custom_Extension.md">Custom extension 만들기</a> 문서를 참조합니다.</dd>
  <dt id="CustomExtMessage"><strong>Custom extension 메시지</strong></dt>
  <dd><a href="#CEK">CLOVA Extensions Kit</a>와 <a href="#CustomExtension">custom extension</a> 사이에서 정보를 주고 받을 때 사용하는 메시지입니다. 자세한 내용은 <a href="/Develop/References/Custom_Extension_Message.md">Custom extension 메시지</a> 문서를 참조합니다.</dd>
  <dt id="Extension"><strong>Extension</strong></dt>
  <dd><a href="#CLOVAExtension">CLOVA extension</a>의 다른 표현</dd>
  <dt id="ExtensionPage"><strong>Extension 페이지</strong></dt>
  <dd>Skill Store 홈 (<strong>확장 서비스 관리</strong> 메뉴)에서 특정 extension을 선택했을 때 표시되는 페이지로 extension에 대한 자세한 설명을 제공하는 페이지입니다.</dd>
  <dt id="Intent"><strong>Intent</strong></dt>
  <dd>Intent는 CLOVA extension이 처리할 사용자의 요청을 구별한 범주이며, custom intent와 built-in intent로 나뉩니다. <a href="#CustomExtension">Custom extension</a>을 구현하기 전에 먼저 intent의 집합으로 구성된 <a href="#InteractionModel">interaction 모델</a>을 정의해야 합니다. 자세한 내용은 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">interaction 모델 정의</a>를 참조합니다.</dd>
  <dt id="IntentRequest"><strong>IntentRequest</strong></dt>
  <dd>사용자의 요청이 분석된 결과(<a href="#Intent">Intent</a>)를 <a href="#CustomExtension">custom extension</a>으로 전달할 때 사용되는 요청 메시지 타입입니다. 자세한 내용은 <a href="/Develop/Guides/Build_Custom_Extension.md#HandleCustomExtensionRequest">Custom extension 요청 처리하기</a> 문서를 참조합니다.</dd>
  <dt id="InteractionModel"><strong>Interaction 모델</strong></dt>
  <dd><a href="#CLOVA">CLOVA</a>가 사용자의 발화를 어떻게 인식하게 할 것인지 정의한 것으로 각 <a href="#CustomExtension">custom extension</a>에 필요한 interaction 모델을 등록할 수 있습니다. 등록된 interaction 모델은 CLOVA의 <a target="_blank" href="https://en.wikipedia.org/wiki/Natural-language_understanding">자연어 이해(NLU)</a> 시 이용되며, CLOVA는 이 interaction 모델에 의해 처리된 사용자의 요청을 정형화된 포맷(JSON)으로 바꾸어 custom extension에 전달합니다. 자세한 내용은 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">interaction 모델 정의</a> 문서를 참조합니다.</dd>
  <dt id="LaunchRequest"><strong>LaunchRequest</strong></dt>
  <dd>사용자가 특정 모드나 특정 <a href="#CustomExtension">custom extension</a>을 사용하기로 선언한 것을 알리기 위해 보내는 요청 메시지입니다. 자세한 내용은 <a href="/Develop/Guides/Build_Custom_Extension.md#HandleCustomExtensionRequest">Custom extension 요청 처리하기</a> 문서를 참조합니다.</dd>
  <dt><strong>OAuth 2.0</strong></dt>
  <dd>접근 권한을 위임하기 위한 공개 표준으로 인터넷 사용자가 다른 웹 서비스나 응용 프로그램의 사용자 계정에 접근할 수 있는 권한을 부여하는 규약입니다. CLOVA 플랫폼에서는 클라이언트가 <a href="#CLOVAAccessToken">CLOVA access token</a>을 획득하거나 사용자가 특정 extension을 사용 시 자신의 <a href="/Develop/Guides/Link_User_Account.md">계정을 연결</a>할 때 사용됩니다. 자세한 내용은 <a target="_blank" href="https://tools.ietf.org/html/rfc6749">https://tools.ietf.org/html/rfc6749</a>를 참고합니다.</dd>
  <dt id="SessionEndedRequest"><strong>SessionEndedRequest</strong></dt>
  <dd>사용자가 특정 모드나 특정 <a href="#CustomExtension">custom extension</a>의 사용을 중지하기로 선언한 것을 알리기 위해 사용되며 요청 메시지에 포함됩니다. 자세한 내용은 <a href="/Develop/Guides/Build_Custom_Extension.md#HandleCustomExtensionRequest">Custom extension 요청 처리하기</a> 문서를 참조합니다.</dd>
  <dt id="Skill"><strong>Skill</strong></dt>
  <dd>CLOVA가 제공하는 사용자에게 제공하는 확장 기능이나 서비스를 의미합니다. Skill을 사용자에게 제공하려면 <a href="#CLOVAExtension">CLOVA extension</a>을 개발해야 합니다.</dd>
  <dt id="SkillStore"><strong>Skill Store</strong></dt>
  <dd>Skill이 사용자에게 제공될 수 있도록 만든 플랫폼입니다.</dd>
  <dt id="SkillStoreHome"><strong>Skill Store 홈</strong></dt>
  <dd>Skill Store에 등록된 skill이 표시되는 페이지입니다. CLOVA 앱의 <strong>확장 서비스 관리</strong> 메뉴를 지칭하는 용어입니다.</dd>
  <dt id="Slot"><strong>Slot</strong></dt>
  <dd><a href="#Intent">Intent</a>에 선언된 요청을 처리할 때 필요한 정보이며, intent를 정의할 때 함께 정의해야 합니다. CLOVA는 사용자 요청을 분석한 후 slot에 해당하는 정보를 추출하게 됩니다. 자세한 내용은 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">interaction 모델 정의</a>를 참조합니다.</dd>
  <dt id="AccountLinking"><strong>사용자 계정 연결 (Account Linking)</strong></dt>
  <dd>사용자의 계정 인증(authentication)이 필요한 외부 서비스를 <a href="#CLOVAExtension">extension</a>이 제공해야 할 때 사용됩니다. 자세한 내용은 <a href="/Develop/Guides/Link_User_Account.md">사용자 계정 연결하기</a> 문서를 참조합니다.</dd>
  <dt id="UserUtteranceExample"><strong>사용자 발화 예시</strong></dt>
  <dd>사용자의 요청 발화가 어떤 식으로 입력될 수 있는지 예문을 표현한 목록입니다. <a href="#Intent">Intent</a>별로 복수의 사례를 정의할 수 있으며, 예문에는 <a href="#Slot">slot</a>이 표시됩니다. 자세한 내용은 <a href="/Design/Design_Custom_Extension.md#DefineInteractionModel">interaction 모델 정의</a>를 참조합니다.</dd>
  <dt id="SessionID"><strong>세션 ID</strong></dt>
  <dd>세션 ID는 <a href="#CLOVAExtension">extension</a>이 사용자 요청의 맥락을 구분하기 위한 세션 식별자입니다. 일반적으로 일회성의 사용자 요청은 매번 달라지는 세션 ID를 가지지만, 특정 모드나 연속되는(multi-turn) 사용자의 요청이면 같은 세션 ID를 가집니다. 이 세션 ID는 <a href="#CEK">CLOVA Extensions Kit</a>가 extension에 사용자 요청을 전달할 때 생성됩니다. 세션 ID가 유지되는 때는 <a href="#LaunchRequest">LaunchRequest</a>와 같은 요청을 받거나 extension이 필요에 의해 `response.shouldEndSession` 필드를 `false`로 설정했을 때입니다. 자세한 내용은 <a href="/Develop/Guides/Build_Custom_Extension.md">Custom extension 만들기</a> 문서를 참조합니다.</dd>
</dl>

<!-- End of the shared content -->
