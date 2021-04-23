<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

# Custom extension 등록하기
[Custom extension](/Develop/Guides/Build_Custom_Extension.md)을 개발 중이거나 개발하고 있다면 이를 [CLOVA developer console](/DevConsole/ClovaDevConsole_Overview.md)에 등록해야 합니다. CEK 메뉴 페이지에서 페이지 하단에 있는 **{{ book.DevConsole.cek_new_skill }}** 버튼을 누르면 신규 custom extension을 등록할 수 있습니다.

![DevConsole-First_Look_of_Extension_List](/DevConsole/Assets/Images/DevConsole-First_Look_of_Extension_List.png)

Custom extension을 등록할 때 일반적으로 다음 항목을 순차적으로 수행해야 합니다.

<ol>
  <li><a href="#AgreeTermsOfUse">이용 약관 및 개인 정보 수집 동의</a></li>
  <li><a href="#InputExtensionInfo">Custom extension 기본 정보 입력</a></li>
  <li><a href="#SetServerConnection">서버 연동 설정</a>
    <ul>
      <li><a href="#SetAccountLinking">계정 연결 설정</a></li>
    </ul>
  </li>
</ol>

<!-- Start of the shared content: AgreeTermsOfUse -->

## 이용 약관 및 개인 정보 수집 동의 {#AgreeTermsOfUse}

Custom extension을 등록하기 전에 우선 CEK API 서비스 이용 약관과 개인 정보 수집에 동의해야 합니다. 이용 약관 및 개인 정보 수집에 대한 내용은 **최초 한 번만 표시**되며 동의한 이후에는 나타나지 않습니다.

![DevConsole-Agree_Terms_of_Use_and_Collecting_Personal_Info](/DevConsole/Assets/Images/DevConsole-Agree_Terms_of_Use_and_Collecting_Personal_Info.png)

<!-- End of the shared content -->

## Custom extension 기본 정보 입력 {#InputExtensionInfo}

Custom extension을 등록하는 과정에서 가장 먼저 할 일은 등록할 custom extension의 기본 정보를 입력하는 것입니다. Custom extension의 기본 정보는 CLOVA developer console에 custom extension을 생성하기 위한 필수 정보입니다. Custom extension의 기본 정보를 입력하고 나면 CEK 메뉴에서 생성한 custom extension을 언제든지 접근 또는 수정할 수 있게 됩니다.

다음 절차에 따라 custom extension을 등록합니다.

![DevConsole-Create_New_Custom_Extension](/DevConsole/Assets/Images/DevConsole-Create_New_Custom_Extension.png)

<style>
ol>li>ol {
    list-style-type: lower-alpha;
}
</style>

<ol>
  <li><strong>{{ book.DevConsole.cek_type }}</strong> 항목에서 등록할 custom extension의 타입을 선택하십시오.<br />Custom extension 타입을 선택하면 그에 해당하는 입력 필드가 추가로 나타납니다.</li>
  <li><strong>{{ book.DevConsole.cek_lang }}</strong> 항목에서 custom extension에서 사용할 언어를 선택하십시오. 현재 <strong>{{ book.DevConsole.supported_languages }}</strong>만 지원하고 있습니다.</li>
  <li><strong>Extension의 ID</strong>, <strong>Skill 이름</strong>, <strong>호출 이름</strong>, <strong>제작사</strong>에 해당하는 정보를 다음 항목에 입력하십시오.
    <ol>
      <li><strong>{{ book.DevConsole.cek_id }}</strong><br />
          Custom extension의 고유 ID를 입력하십시오. 입니다. Reverse domain name 표기 형식(예: com.example.extension.pizzabot)으로 입력합니다.</li>
      <li><strong>{{ book.DevConsole.cek_name }}</strong><br />
          Custom extension의 이름을 입력하십시오. 추후 <strong>{{ book.DevConsole.ManageCustomExtensions }}</strong>에 노출됩니다.</li>
      <li><strong>{{ book.DevConsole.cek_invocation_name }}</strong><br />
          사용자가 custom extension을 호출할 때 부를 이름을 입력하십시오. 한 개 이상 최대 세 개까지 {{ book.DevConsole.cek_invocation_name }}을 등록할 수 있습니다. 일반적으로 보유하고 있는 서비스, 회사 또는 조직의 이름이 될 수 있으나 사용자의 편의를 위해 간결하고 특색있는 단어를 지정하는 것이 좋습니다. 범용적인 단어나 타사의 이름이나 서비스에 해당하는 용어는 사용할 수 없습니다. <strong>{{ book.DevConsole.cek_invocation_name }}</strong>은 custom extension 심사 시 검수받게 됩니다.</li>
      <li><strong>{{ book.DevConsole.cek_provider }}</strong><br />
          Custom extension의 제작 주체(회사나 개인)의 이름 또는 별칭을 입력하십시오. 추후 <strong>{{ book.DevConsole.ManageCustomExtensions }}</strong>에 노출되며, custom extension 승인 과정에서 심사를 받게 됩니다.</li>
    </ol>
  </li>
  <li>(Extension이 <a href="{{ book.DocMeta.CLOVAClientDeveloperGuideBaseURI }}/Develop/References/MessageInterfaces/AudioPlayer.{{ book.DocMeta.FileExtensionForExternalLink }}">AudioPlayer</a> 지시 메시지를 이용한다면) <strong>{{ book.DevConsole.cek_audioplayer }}</strong> 항목을 <strong>{{ book.DevConsole.cek_yes }}</strong>로 선택하십시오. Custom extension이 음악 스트리밍 서비스를 제공할 때 사용됩니다.</li>
  <li><strong>{{ book.DevConsole.cek_email }}</strong> 항목에 연락 가능한 이메일 주소를 입력하십시오.</li>
  <li><strong>{{ book.DevConsole.cek_tester }}</strong> 항목에 개발 중인 custom extension을 테스트할 때 이용할 {{ book.ServiceEnv.OrientedService }} 계정을 입력하십시오.<br />당장 입력하지 않아도 되며 추후 <a href="/DevConsole/Guides/Test_Custom_Extension.md">extension을 테스트</a>해야 할 때 이 필드에 값을 입력할 수 있습니다.</li>
  <li>Custom extension의 기본 정보를 모두 입력한 후 <strong>{{ book.DevConsole.cek_create }}</strong> 버튼을 누르십시오.</li>
</ol>

Custom extension의 기본 정보 입력이 끝나면 생성된 Custom extension의 정보를 수정하는 화면으로 전환됩니다. 이때부터 페이지 하단에 있는 **{{ book.DevConsole.cek_save }}** 버튼을 클릭하여 중간 내용을 언제든지 저장할 수 있으며, 다음과 같이 CEK 메뉴에서 등록된 Custom extension 목록을 확인할 수 있습니다.

![DevConsole-Custom_Extension_List_After_Creation](/DevConsole/Assets/Images/DevConsole-Custom_Extension_List_After_Creation.png)

## 서버 연동 설정 {#SetServerConnection}

Custom extension은 CEK와 HTTPS 통신을 수행하게 됩니다. 이때, CEK는 Custom extension쪽으로 HTTP 요청을 보내고, Custom extension은 HTTP 응답을 CEK에 보냅니다. CEK가 custom extension으로 HTTP 요청을 보내려면 CLOVA developer console에서 서버 연동 설정을 수행해야 합니다. [Custom extension 기본 정보를 입력](#InputExtensionInfo)한 후 생성된 custom extension에 대해 서버 연동 설정을 수행할 수 있습니다.

Custom extension 서버를 등록하기 전에 우선 custom extension 서버와 통신이 되는지 확인해야 합니다. 다음 예와 같이 간단한 curl 명령으로 통신 상태를 확인할 수 있습니다.

{% raw %}
```bash
$ curl "https://example.com/pizzabot" -X POST
```
{% endraw %}

다음 절차에 따라 서버 연동 설정을 수행합니다.

![DevConsole-Custom_Extension_Server_Settings](/DevConsole/Assets/Images/DevConsole-Custom_Extension_Server_Settings.png)

1. Extension 정보 입력 UI에서 위쪽에 있는 **{{ book.DevConsole.cek_configuration }}** 탭을 누르십시오.
2. Custom extension 서버 URI(endpoint) 정보를 **{{ book.DevConsole.cek_service_endpoint_url }}** 항목에 입력하십시오.
3. ([사용자 계정 연결](#SetAccountLinking)이 필요하다면) **{{ book.DevConsole.cek_account_linking }}** 항목을 **{{ book.DevConsole.cek_yes }}**로 선택하십시오.
4. **{{ book.DevConsole.cek_ssl_certificate }}** 항목의 라디오 버튼을 누르십시오. Custom extension을 제공하는 서버는 반드시 공인된 인증 기관의 인증서를 사용해야 합니다. (Self-signed 인증서 사용 불가)
5. 서버 연동 설정과 관련된 내용을 입력한 후 **{{ book.DevConsole.cek_save }}** 버튼을 누르십시오.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>테스트 단계에서는 HTTP도 가능하나 정식 서비스를 위해서는 HTTPS여야 합니다. Custom extension 서버는 HTTP일 때 80 번 포트를 HTTPS일 때 443 번 포트를 사용해야 합니다.</p>
</div>

### 계정 연결 설정 {#SetAccountLinking}

Custom extension으로 제공하려는 서비스의 사용자 계정이 CLOVA의 사용자 계정과 연결이 필요하다면 [서버 연동 설정](#SetServerConnection) 중에 [계정 연결(account linking)](/Develop/Guides/Link_User_Account.md)에 관련된 정보를 입력해야 합니다.

다음 절차에 따라 계정 연결 설정에 [필요한 정보](/Develop/Guides/Link_User_Account.md#RegisterAccountLinkingInfo)를 입력합니다.

<img src="/DevConsole/Assets/Images/DevConsole-Custom_Extension_Accoun_Linking_Settings_1.png" />

<ol>
  <li><strong>{{ book.DevConsole.cek_account_linking }}</strong> 항목에서 <strong>{{ book.DevConsole.cek_yes }}</strong>를 선택하십시오.</li>
  <li>사용자가 계정 인증을 할 수 있도록 UI를 제공하는 Authorization URI를 <strong>{{ book.DevConsole.cek_authorization_url }}</strong> 항목에 입력하십시오.<br />
      사용자가 custom extension을 활성화하면 이 페이지로 이동됩니다.</li>
  <li>(만약, 사용자가 본인 계정을 바로 설정할 수 있도록 하고 싶다면) <strong>{{ book.DevConsole.cek_configuration_url }}</strong> 항목에 계정 설정 페이지의 URI를 입력하십시오.</li>
  <li>사용자 계정 인증 시 HTTP 요청에 필요한 <strong>{{ book.DevConsole.cek_client_id }}</strong>를 입력하십시오.<br />
      클라이언트 ID는 <a href="/Develop/Guides/Link_User_Account.md#BuildAuthServer">인증 서버를 구축</a>할 때 생성한 값입니다.</li>
  <li><strong>{{ book.DevConsole.cek_privacy_policy_url }}</strong> 항목에 custom extension이 제공하는 서비스의 개인 정보 보호 정책과 관련된 내용이 제공되는 페이지의 URI를 입력하십시오.<br />
      이 페이지의 내용은 추후 <strong>{{ book.DevConsole.ManageCustomExtensions }}</strong>에 노출됩니다.</li>
  <li>(만약, <strong>{{ book.DevConsole.cek_authorization_url }}</strong>이나 <strong>{{ book.DevConsole.cek_privacy_policy_url }}</strong>에 등록한 페이지가 다른 도메인에서 자원을 가져온다면) <strong>{{ book.DevConsole.cek_domain_list }}</strong> 항목에 필요한 도메인을 추가하십시오.</li>
  <li>(선택 사항) 만약, 사용자 계정 연결 시 발급되는 access token의 사용 범위(scope)를 미리 정의했다면 <strong>{{ book.DevConsole.cek_scope }}</strong> 항목에 미리 정의한 범위를 추가하십시오.<br />
    <img src="/DevConsole/Assets/Images/DevConsole-Custom_Extension_Accoun_Linking_Settings_2.png" />
  </li>
  <li><strong>{{ book.DevConsole.cek_access_token_uri }}</strong> 항목에 서비스의 access token을 발급 받을 수 있는 URI를 입력하십시오.<br />
      현재 <strong>허가 승인 타입(grant type)은 code grant 방식만 지원</strong>하고 있습니다.</li>
  <li><strong>{{ book.DevConsole.cek_refresh_token_uri }}</strong> 항목에 서비스의 access token을 갱신할 수 있는 URI를 입력하십시오.</li>
  <li>서비스의 access token을 획득 시 HTTP 요청에 필요한 <strong>{{ book.DevConsole.cek_client_secret }}</strong>을 입력하십시오.<br />
      클라이언트 secret은 <a href="/Develop/Guides/Link_User_Account.md#BuildAuthServer">인증 서버를 구축</a>할 때 생성한 값입니다.</li>
  <li><strong>{{ book.DevConsole.cek_client_authentication_scheme }}</strong>은 다음 중 인증 서버의 인터페이스 구현에 맞는 값을 설정하십시오.
    <ul>
      <li><strong>HTTP Basic (Recommended)</strong>: 서비스 access token을 획득하기 위해 인증 정보(Credentials)를 헤더에 입력받을 때</li>
      <li><strong>Credentials in request body</strong>: 서비스 access token을 획득하기 위해 인증 정보를 본문(body)에 입력받을 때</li>
    </ul>
  </li>
</ol>

<div id="RedirectURI" class="note">
  <p><strong>Note!</strong></p>
  <p>계정 인증 후 클라이언트가 이동할 URI(redirect URI)은 <code>{{ book.ServiceEnv.RedirectURIforAccountLinking }}</code>이며, <strong>{{ book.DevConsole.cek_redirect_urls }}</strong> 항목에서 확인할 수 있습니다.</strong> <a href="/Develop/Guides/Link_User_Account.md#BuildAuthServer">인증 서버</a>는 클라이언트가 전달하는 <code>redirect_uri</code>의 값이 이 값과 같은지 검증해야 합니다.</p>
  <img src="/DevConsole/Assets/Images/DevConsole-Redirect_URI_for_Extension_Accoun_Linking.png" />
</div>
