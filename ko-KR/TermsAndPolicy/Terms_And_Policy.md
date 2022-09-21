# 준수사항 및 운영정책

Skill(extension)을 통해 콘텐츠를 사용자에게 제공할 때 지켜야하는 준수사항이 있습니다. CLOVA 운영자는 Skill Store에 [skill을 배포](/DevConsole/Guides/Deploy_Custom_Extension.md)하기 전에 이 준수 사항을 위반했는지 심사합니다. Skill이 준수 사항을 위반하거나 명확히 따르지 않으면 배포를 거부하거나 이미 배포된 skill 제공을 중단할 수 있습니다. 따라서, [심사를 신청](/DevConsole/Guides/Deploy_Custom_Extension.md#RequestExtensionSubmission)하기 전에 반드시 이하의 준수 사항을 따랐는지 확인해야 합니다.

* [Skill의 완전성](#SkillCompleteness)
* [Skill의 안전성](#SkillSecurity)
* [권리 보호 및 법 준수](#RightAndLegal)
* [윤리 이행](#Morals)
* [개인 정보 보호](#Privacy)
* [기타 유의 사항](#OtherPrecautions)

## Skill의 완전성 {#SkillCompleteness}

편의 제공 및 불편 해소와 같이 보다 나은 사용자 경험을 위해 다음을 준수하여 완전성을 추구해야 합니다.

* 서버 점검과 같이 특수한 상황을 제외하고 skill은 사용자의 요청에 언제든지 응답할 수 있어야 합니다.
* Skill에 대한 정보인 [기본 정보](/DevConsole/Guides/Register_Custom_Extension.md#InputExtensionInfo), [서버 설정 정보](/DevConsole/Guides/Register_Custom_Extension.md#SetServerConnection), [배포 정보](/DevConsole/Guides/Deploy_Custom_Extension.md#InputDeploymentInfo)가 부족하거나 잘못된 정보 없이 항상 최신의 정보로 업데이트되어야 합니다.
* [사용 시나리오](/Design/Design_Custom_Extension.md#MakeUseCaseScenarioScript)에 불가능하거나 자연스럽지 않은 부분이 없어야 하며, 사용자의 요청이 잘 인식될 수 있도록 [interaction 모델](/Design/Design_Custom_Extension.md#DefineInteractionModel) 잘 정의하여 구현해야 합니다.
* 콘텐츠 제공을 위해 서버를 연동하거나 계정을 연결한다면 필요한 [보안 조건](/Develop/Guides/Link_User_Account.md#ApplyAccountLinking)을 갖춰야 합니다.

따라서, 다음과 같은 상황이 발생하면 지체 없이 그에 대해서 확인하고, 오류 수정 후 재등록과 같은 정상 동작을 위한 조치를 취해야 하며, 그 결과를 회사에 통지해야 합니다.

* 운영 중인 skill이 정상 동작하지 않을 때
* 위의 이유로 문제를 스스로 인지하거나 {{ book.DocMeta.DocOwner }}가 연락을 한 때

<div class="warning">
  <p><strong>Warning!</strong></p>
  <p>이와 같은 조치를 하지 않아 해당 skill이 정상적으로 동작하지 않은 기간이 1 개월 이상 지속되면, {{ book.DocMeta.DocOwner }}는 해당 skill의 운영을 중단시킬 수 있습니다.</p>
</div>

## Skill의 안전성 {#SkillSecurity}

사용자의 안전을 보장하기 위해 다음 사항을 준수해야 합니다.

* 사람의 생명 또는 신체의 안전을 해칠 우려가 있는 행위를 유도하거나 조장하지 않아야 합니다.
* 청소년의 가출이나 탈선을 유도하거나 조장하지 않아야 합니다.
* {{ book.DocMeta.DocOwner }} 또는 제 3 자의 기기, 설비, 시스템과 같은 것의 이용을 방해하거나 운용에 지장을 주지 않아야 합니다.
* {{ book.DocMeta.DocOwner }} 또는 제 3 자의 설비에 축적된 정보를 불법적으로 바꾸거나 제거하지 않아야 합니다.
* 바이러스와 같은 유해 프로그램을 포함하거나 송신하지 않아야 합니다.

## 권리 보호 및 법 준수 {#RightAndLegal}

Skill은 다음과 같은 사항을 준수하여 권리 보호 및 법 준수의 의무를 지켜야 합니다.

* {{ book.DocMeta.DocOwner }} 또는 제 3 자의 권리(저작권, 지적재산권, 초상권, 성명권, 인격권, 명예와 같은 것)을 침해하지 않아야 합니다.
* 권리의 소재가 명확하지 않은 콘텐츠를 제공하지 않아야 합니다. (예: 2 차 창작과 같은 것)
* 권리자로부터 허락받지 않았거나 허락받았음을 증명할 수 없는 콘텐츠를 제공하지 않아야 합니다.
* 도박과 같이 기타 불법적인 행위를 유도하거나 조장하는 콘텐츠를 제공하지 않아야 합니다.
* 성범죄, 노골적인 성행위 묘사, 아동 포르노, 아동 학대와 관련된 콘텐츠 뿐만 아니라 기타 잔혹하거나 외설적인 표현 또는 이를 연상시키는 콘텐츠를 제공하지 않아야 합니다.
* 기타 범죄를 구상 또는 조장하거나 미풍양속 또는 법규를 위반하거나 위반할 우려가 있는 콘텐츠를 제공하지 않아야 합니다.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>심사 시 콘텐츠의 권리를 확인하기 위해 권리 확인이 가능한 서류를 요청할 수도 있습니다.</p>
</div>

## 윤리 이행 {#Morals}

Skill은 다음과 같이 윤리적인 규범에 해당하는 사항도 준수해야 합니다.

* 사용자가 특정 개인이나 집단, 법인, 국가와 같은 것 비방, 욕설, 공격, 혐오하지 않도록 만들어야 합니다.
* 사용자가 특정 종교, 문화, 민족성, 국민성을 공격하거나 그것에 대해 불쾌감을 느끼지 않도록 만들어야 합니다.
* Skill이 반 사회적인 내용을 포함하거나 또는 불쾌감을 주지 않아야 합니다.
* 사용자가 {{ book.DocMeta.DocOwner }}가 skill을 개발 및 제공한다고 오해하거나 혼동하지 않도록 만들어야 합니다.
* {{ book.DocMeta.DocOwner }} 또는 제 3 자를 부당하게 차별, 비방하지 않아야 하며 이런 행위를 유도하거나 조장하지 않아야 합니다.

## 개인 정보 보호 {#Privacy}

Skill은 개인 정보 보호의 의무를 지켜야 합니다.

* CLOVA 이용 데이터와 같이 기타 개인 정보를 수집하지 않아야 합니다.
* 다음과 같은 민감한 정보를 수집하지 않아야 합니다.
  * 인종, 종교, 사회적 신분, 병력, 전과, 범죄 피해 정보
  * 장애, 지적 장애·정신 장애에 대한 정보
  * 건강 진단 그 외의 다른 검사의 결과
  * 의료 기록, 진료 및 투약 정보
  * 피의자 또는 피고인으로서 구속, 수색과 같은 민사 또는 형사 사건에 관련된 정보

## 기타 유의 사항 {#OtherPrecautions}

Skill 콘텐츠 제공과 관련하여 다음과 같은 유의 사항이 있습니다.

* Skill이 본인(당사) 또는 제 3 자의 기기(예: IoT기기)와 연동된다면 심사를 위해 관련 기기 제출을 요청할 수도 있습니다.
* 위에서 언급한 내용 뿐만 아니라 Skill은 [CLOVA Extensions Kit 이용약관]({{ book.ServiceEnv.CEKTermsOfUseURI }})을 위반하지 않아야 합니다.

<div class="note">
<p><strong>Note!</strong></p>
<p>일부 예외가 있을 수 있기 때문에 판단이 어려울 수 있으며, 이에 대한 판단이 어렵다면 <a href="/DevConsole/Guides/Deploy_Custom_Extension.md#RequestExtensionSubmission">심사 시</a>에 의견을 입력해주십시오.</p>
</div>
