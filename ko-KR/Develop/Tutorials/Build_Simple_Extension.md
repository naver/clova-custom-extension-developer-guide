# 기초적인 extension 만들기
이 튜토리얼에서는 주사위를 굴려달라는 사용자의 요청에 1 개의 주사위만 굴려주는 기초적인 extension을 만듭니다.

Custom extension을 서비스하려면 아래 두 가지 요소가 꼭 필요합니다.

{% include "/Develop/Guides/RequiredComponents/Interaction_Model.md" %}

{% include "/Develop/Guides/RequiredComponents/Extension_Server.md" %}

다음과 같은 과정을 통해 위 두 요소를 만들고 등록하는 방법을 알아봅니다.

Extension을 만드는 전체적인 과정은 다음과 같습니다.
* 1 단계. Extension 서버 준비(개별적으로 작업)
* 2 단계. Extension 기본 정보 등록(CLOVA developer console에서 작업)
* 3 단계. Interaction 모델 등록(CLOVA developer console에서 작업)
* 4 단계. Extension 동작 테스트(CLOVA developer console과 실제 기기에서 작업)

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>이렇게 만든 extension을 실제 서비스하려면 <a href="/DevConsole/Guides/Deploy_Custom_Extension.md">Extension 배포하기</a>를 참조하십시오.</p>
</div>

## 1 단계. Extension 서버 준비 {#Step1}

샘플 주사위 extension이 등록한 slot을 잘 처리하는지 테스트해야 합니다.

[첫 번째 튜토리얼](/Develop/Tutorials/Build_Simple_Extension.md)에서처럼 두 가지 테스트 방법이 있습니다. 하나는 CLOVA developer console에서 interaction 모델 동작을 확인하는 것이고, 다른 하나는 테스터 아이디를 등록하여 CLOVA 앱에서 실제 동작을 확인하는 것입니다.
이 튜토리얼에서는 interaction 모델 동작만 확인합니다.

<a href="{{ book.ServiceEnv.DeveloperConsoleURI }}/cek/#/list" target="_blank">CLOVA developer console</a>에 접속하여 다음과 같이 샘플 주사위 extension이 주사위 개수를 잘 인식하는지 확인합니다.

<ol>
  <li>샘플 주사위의 <strong>{{ book.DevConsole.cek_interaction_model }}</strong> 항목 내 <strong>{{ book.DevConsole.cek_edit}}</strong> 버튼을 누르십시오.</li>
  <li>화면 좌측 상단의 <strong>{{ book.DevConsole.cek_builder_menu_build }}</strong> 버튼을 눌러 interaction 모델을 빌드하십시오.</li>
  <li>빌드가 끝난 후, 왼쪽의 메뉴 목록에서 <strong>{{ book.DevConsole.cek_test }}</strong> 메뉴를 선택하십시오.</li>
  <li><strong>{{ book.DevConsole.cek_builder_test_expression_title }}</strong>에 주사위를 여러 개 던져달라는 문장을 입력하십시오. 예를 들어, "주사위 두 개 던져볼래"라고 입력합니다.</li>
  <li>엔터키 또는 <strong>{{ book.DevConsole.cek_builder_test_request_test }}</strong> 버튼을 누르십시오.</li>
  <li><strong>{{ book.DevConsole.cek_builder_test_result_title }}</strong>의 <strong>{{ book.DevConsole.cek_builder_test_intent_result }}</strong> 항목에 <code>ThrowDiceIntent</code>, <strong>{{ book.DevConsole.cek_builder_test_slot_result }}</strong> 항목에 <code>diceCount</code>가 나타나고, <strong>{{ book.DevConsole.cek_builder_test_slot_data}}</strong>에 입력한 주사위 개수가 나타나는지 확인하십시오.<br />
    <img alt="CEK_Tutorial_Builtin_Type_Slot_Test" src="/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slot_Test.png" />
    <div class="note">
      <p><strong>Note!</strong></p>
      <p>외부에서 접근할 수 있는 extension 서버 URI를 등록하지 않았다면, <strong>{{ book.DevConsole.cek_builder_test_service_response }}</strong>은 "{{ book.DevConsole.cek_builder_test_no_response }}"라고 나타납니다.</p>
    </div>
  </li>
  <li>"주사위 열 개 굴려", "네 개 주사위 던져"와 같은 문장으로 4-6 단계를 반복하십시오.</li>
</ol>

인식이 잘 되지 않으면 좀 더 다양한 발화 예시를 추가하여 인식 확률을 높일 수 있습니다.

### Extension 서버 개발 팁 {#Tip}

CLOVA는 사용자의 음성 입력을 분석한 결과를 extension 서버에 전송하며, 서버는 수신한 내용에 맞게 응답하도록 구현해야 합니다.

* **분석한 결과가 별도로 등록한 사용자 의도([Custom intent](/Design/Design_Custom_Extension.md#CustomIntent))이면,**

	CLOVA는 extension 실행, 등록한 의도 실행, extension 종료 중 하나의 요청 메시지를 전송하며, 서버는 각각의 메시지에 따라 extension 시작, 지정된 의도 처리, extension 종료를 처리한 후 그 결과를 반환하면 됩니다.

* **분석한 결과가 CLOVA가 기본적으로 제공하는 의도([Built-in intent](/Design/Design_Custom_Extension.md#BuiltinIntent))이면,**

	CLOVA는 그에 따라 도움말 안내, 긍정, 부정, 실행 취소와 같은 요청 메시지를 전송하며, 서버는 이에 따른 일반적인 응답을 하면 됩니다.

## 2 단계. Extension 기본 정보 등록 {#Step2}

<a href="{{ book.ServiceEnv.DeveloperConsoleURI }}/cek/#/list" target="_blank">CLOVA developer console</a>에 접속하여 extension의 기본 정보를 등록합니다.
주요 항목은 아래와 같습니다.

* Extension 정보
  * **{{ book.DevConsole.cek_id }}**: extension의 고유한 ID 값으로, 일반적으로 패키지 이름과 extension 이름의 조합으로 작성합니다. 샘플 주사위 extension의 ID는 "my.clova.extension.sampledice"로 입력합니다.
  * **{{ book.DevConsole.cek_invocation_name }}**: extension을 실행할 때 부르는 이름으로 CLOVA 앱이나 스피커 형태의 기기에서 음성 인식이 잘 되는 단어를 선택합니다. 샘플 주사위 extension의 호출 이름은 "샘플 주사위" 입니다.
* 서버 연동 설정
  * **{{ book.DevConsole.cek_service_endpoint_url }}**: CLOVA와 통신할 extension의 REST API 서버로, 외부에서 접근할 수 있는 URI여야 합니다. 1 단계에서 샘플 주사위 소스 코드를 실행한 서버의 주소를 입력합니다.
		<div class="note">
			<p><strong>Note!</strong></p>
			<p>테스트 단계에서는 HTTP도 가능하나 정식 서비스를 위해서는 HTTPS여야 합니다. Extension 서버는 HTTP일 때 80 번 포트를 HTTPS일 때 443 번 포트를 사용해야 합니다.</p>
		</div>
  * **{{ book.DevConsole.cek_account_linking }}**: 인증 서버(OAuth 2.0기반)를 사용해 3rd party의 회원정보와 연동할 때만 사용합니다. 샘플 주사위 extension은 **{{ book.DevConsole.cek_no }}**로 설정합니다.
* 배포 정보 및 개인 정보 보호 및 규정 준수<br />
  Extension 배포와 심사에 필요한 정보입니다. 이 튜토리얼의 내용을 수행할 때는 입력하지 않아도 됩니다.

## 3 단계. Interaction 모델 등록 {#Step3}

<a href="{{ book.ServiceEnv.DeveloperConsoleURI }}/cek/#/list" target="_blank">CLOVA developer console</a>에서 interaction 모델을 등록합니다.

이 튜토리얼에서 샘플 주사위는 사용자가 개수를 지정하지 않고 주사위를 던져달라는 요청을 하면 기본적으로 주사위 1 개를 던집니다. 여기서는 이렇게 주사위 1 개를 던지는 명령을 처리하는 단순한 interaction 모델을 사용하기로 합시다. 주사위 개수를 수집하지 않으므로 slot이 없는 intent 하나를 등록하면 됩니다.

### 새로운 custom intent 만들기
여기서는 주사위를 던져달라는 요청에 주사위 1 개를 던지도록 간단한 intent를 생성합니다.

1. 샘플 주사위의 **{{ book.DevConsole.cek_interaction_model }}** 항목 내 **{{ book.DevConsole.cek_edit }}** 버튼을 누르십시오.
2. **{{ book.DevConsole.cek_builder_list_title_intent }}** 오른쪽에 있는 <img class="inlineImage" src="/Develop/Assets/Images/DevConsole_Plus_Button.png" /> 버튼을 누르십시오.
3. **{{ book.DevConsole.cek_builder_new_intent }}** 아래 입력창에 "ThrowDiceIntent"라는 이름을 입력하십시오.
4. 엔터키 또는 입력창 오른쪽의 **{{ book.DevConsole.cek_builder_new_intent_create }}** 버튼을 누르십시오.<br />
  ![CEK_Tutorial_NewIntent](/Develop/Assets/Images/CEK_Tutorial_NewIntent.png)
	<div class="note">
	  <p><strong>Note!</strong></p>
		<p>Intent 이름의 대소문자에 유의해야 합니다.</p>
	</div>

### 발화 예시 목록에 문장 입력하기
여기서는 사용자가 어떤 말을 할 때 위에 입력한 intent로 처리할지 지정합니다. 발화 예시는 많을수록 좋지만, 이 튜토리얼에서는 하나만 입력합니다.

1. **{{ book.DevConsole.cek_builder_intent_expression_title }}**에서 "주사위 던져줘"라고 입력하십시오.
2. 엔터키 또는 <img class="inlineImage" src="/Develop/Assets/Images/DevConsole_Plus_Button.png" /> 버튼을 누르십시오.
3. 모든 발화 예시를 입력하면 **{{ book.DevConsole.cek_save }}** 버튼을 누르십시오.<br />
  ![CEK_Tutorial_SpeechExample](/Develop/Assets/Images/CEK_Tutorial_SpeechExample.png)

### 빌드 및 테스트하기
Interaction 모델이 입력한대로 동작하는지 확인하기 위해 interaction 모델을 빌드하여 테스트 합니다.

1. **Custom Extension** 화면 좌측 상단의 **{{ book.DevConsole.cek_builder_menu_build }}** 버튼을 누르십시오.
	<div class="note">
	  <p><strong>Note!</strong></p>
		<p>빌드는 3~5 분 정도 소요됩니다. 빌드가 시작되면 버튼이 <strong>{{ book.DevConsole.cek_builder_menu_build_in_progress }}</strong>으로 바뀌며, 빌드가 완료된 후 다시 <strong>{{ book.DevConsole.cek_builder_menu_build }}</strong>로 돌아옵니다.</p>
	</div>
2. 빌드가 완료되면 **{{ book.DevConsole.cek_builder_menu_build }}** 버튼 아래의 **{{ book.DevConsole.cek_test }}** 메뉴를 누르십시오.
3. **{{ book.DevConsole.cek_builder_test_expression_title }}**에 테스트하고자 하는 문장을 입력합니다. 예를 들어, "주사위 던져줄래"라고 입력하십시오.
4. 엔터키 또는 **{{ book.DevConsole.cek_builder_test_request_test }}** 버튼을 누르십시오.
5. **{{ book.DevConsole.cek_builder_test_result_title }}**의 **{{ book.DevConsole.cek_builder_test_intent_result }}** 항목에 "ThrowDiceIntent"라고 나타나는지 확인하십시오.<br />
  ![CEK_Tutorial_Test](/Develop/Assets/Images/CEK_Tutorial_Test.png)
	<div class="note">
  	<p><strong>Note!</strong></p>
  	<p>2 단계에서 외부에서 접근할 수 있는 extension 서버 URI를 등록하지 않았다면, <strong>{{ book.DevConsole.cek_builder_test_service_response }}</strong>은 "{{ book.DevConsole.cek_builder_test_no_response }}"라고 나타납니다.</p>
	</div>

## 4 단계. Extension 실제 동작 테스트 {#Step4}

Interaction 모델이 잘 동작하는 것을 확인했다면, 심사 요청 전에 실제 기기에서 테스트하여 음성 인식과 응답이 기대한대로 동작하는지 확인해야 합니다.

### 테스터 ID 등록하기

특정 계정에서만 이 extension을 실행해볼 수 있도록 테스터 ID를 등록합니다.

1. <a href="{{ book.ServiceEnv.DeveloperConsoleURI }}/cek/#/list" target="_blank">CLOVA developer console</a>에 접속하십시오.
2. 샘플 주사위의 **{{ book.DevConsole.cek_skill_info }}** 항목 내 **{{ book.DevConsole.cek_edit }}** 버튼을 누르십시오.
3. 나타난 화면에서 **{{ book.DevConsole.cek_tester }}**를 찾아 여러분의 {{ book.ServiceEnv.OrientedService }} 계정 ID를 입력하십시오.
4. **{{ book.DevConsole.cek_save }}** 버튼을 누르십시오.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>테스터 ID를 등록한 후 조금 기다리면 extension을 테스트해 볼 수 있습니다. 만약, 1 시간 정도가 지나도 extension을 테스트할 수 없으면 포럼이나 제휴 담당자를 통해 문의하시기 바랍니다.</p>
</div>

<div class="note">
	<p><strong>Note!</strong></p>
  <p>실제 기기에서 테스트 하려면 <strong>{{ book.DevConsole.cek_skill_info }}</strong>에 반드시 외부에서 접속 가능한 실제 extension 서버 주소를 등록해야 합니다.</p></li>
</div>

### CLOVA 앱에서 실행하기

CLOVA 앱을 통해 샘플 주사위 extension을 실행합니다.

1. 테스트할 기기에 CLOVA 앱을 설치하십시오.
2. 테스터 ID로 입력한 {{ book.ServiceEnv.OrientedService }} 계정으로 로그인하십시오.
3. 테스트용 extension 호출 이름으로 음성 명령을 내리십시오. 예를 들어, "클로바, 샘플 주사위에 주사위 던지라고 해"라고 명령합니다.
4. CLOVA 앱이 "주사위를 1 개 던집니다"라고 응답하는지 확인하십시오.

Extension이 실제 기기에서도 잘 동작하면 서비스할 준비가 된 것입니다. 이제 CLOVA developer console에서 심사를 요청하여 extension을 배포할 수 있습니다.
