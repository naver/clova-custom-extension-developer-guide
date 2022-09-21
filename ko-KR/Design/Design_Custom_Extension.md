# Custom extension 설계

새로운 custom extension을 만들 때 보유하고 있는 기술이나 서비스가 CLOVA를 통해 어떤 사용자의 요청을 처리하고 어떤 응답을 반활할 것인지 결정하는 설계 활동을 해야 합니다. 이 문서는 custom extension을 설계하는 방법에 대해 설명합니다. 참고로 CLOVA를 이용하는 사용자에게는 skill이라는 용어로 기능을 제공하게 되며, 사용자에게 skill을 제공하기 위해 개발자는 custom extension을 구현해야 합니다.

웹 서비스의 정보 조회, 쇼핑 및 배달 서비스, 대화형 게임, 방송 또는 실시간 브리핑 및 그 밖의 음성을 통한 활동이나 서비스를 제공하는 custom extension을 만들 수 있습니다. Custom extension을 설계할 때 보통 다음의 절차를 따릅니다. 참고로 여기서 다루는 내용은 custom extension 설계의 기본 권장 사항이며 간단한 예시와 함께 설명하고 있습니다. 물론, 보유하고 있는 사업적 경험과 서비스의 특성에 따라 custom extension이 더 많은 가능성을 가지도록 설계/구현할 수도 있습니다.

* [목표 수립](#SetGoal)
* [사용 시나리오 스크립트 작성](#MakeUseCaseScenarioScript)
* [Skill 이름 정의](#DefineInvocationName)
* [Interaction 모델 정의](#DefineInteractionModel)
* [응답 유형 결정](#DecideSoundOutputType)
* [지속적인 업데이트](#ContinuousUpdate)

## 목표 수립 {#SetGoal}

Custom extension을 설계할 때 가장 먼저 할 일은 custom extension의 목표를 정하는 것입니다. Custom extension의 목표는 구체적으로 사용자에게 무엇을 어떻게 전달할 것인지 정하는 것이라고 보면 됩니다. Custom extension의 목표를 정하는 것은 추후 사용자에게 어떤 기능을 제공하고 이 기능을 사용자가 어떤 시나리오로 사용할지 예상하는 근거가 됩니다. Custom extension의 목표는 다음과 같은 하나의 근본적이고 추상적인 목표가 있을 수 있습니다.

```
사용자에게 피자 배달 서비스를 제공한다.
```

위와 같이 정한 custom extension 목표는 좀 더 구체적인 세부 목표들로 다시 기술될 수 있습니다. 세부 목표를 작성할 때는 다음과 같은 항목을 참고하여 정의합니다.

* 세부 목표는 사용자의 입장에서 작성합니다.
* 세부 목표에는 사용자가 custom extension을 어떻게 호출할 수 있는지에 대한 내용도 포함합니다.
* 세부 목표 달성에 필요한 조건과 성취하게 되는 결과를 조합하여 작성할 것을 권장합니다. 필요조건에는 다음과 같은 것들이 있을 수 있습니다.
  - 사전 필요 동작이나 상태
  - Custom extension이 필요로 하는 기능이나 자원(GPS, 카메라, 마이크)
  - 외부 서비스나 플랫폼의 정보 (모바일 기기 연락처 정보, SNS 계정 정보)
* 세부 목표의 집합이 달성하려는 custom extension 목표의 범위를 모두 포함하고 있는지 확인합니다.
* 하나의 세부 목표는 서비스에서 구분하여 처리하는 하나의 사용자 액션 단위와 같은 수준으로 작성할 것을 권장합니다.

다음은 피자 배달 서비스를 고려하여 만든 세부 목표 예제입니다.

| 세부 목표 ID | 분류                | 목표                                                            |
|:----------:|-----------------------|-----------------------------------------------------------------|
| #1         | 서비스 호출           | 사용자가 "피자봇 시작해줘"나 "피자봇에서 _[등록한 실행 명령어]_"로 발화를 시작하면 피자 배달 서비스를 사용할 수 있다.    |
| #2         | 사용 제안 또는 추천   | 피자 배달 서비스가 시작되면 사용자는 피자 주문 시 예상되는 다음 동작이나 다음 동작에 대한 안내를 제공받을 수 있다.       |
| #3         | 메뉴 조회 및 선택     | 사용자는 피자 메뉴를 조회하고 선택할 수 있다.                                                                            |
| #4         | 브랜드 조회 및 선택   | 사용자는 피자 브랜드를 선택할 수 있다.                                                                                   |
| #5         | 주문 및 결제          | 피자 종류, 수량 및 배달 주소 정보가 있으면 사용자는 피자 주문을 할 수 있다.                                              |
| #6         | 사용 제안 또는 추천   | 사용자는 피자 브랜드를 선택하면 최근 주문한 정보를 통해 피자, 배달 목적지 및 결제 방법을 제안받을 수 있다.               |
| #7         | 사용 제안 또는 추천   | 사용자가 다른 메뉴를 요청하면 사용자는 extension이 추천하는 메뉴를 추천받을 수 있다.                                     |
| #8         | 주문 및 결제          | 사용자는 카메라를 이용하여 결제 시 쿠폰을 적용할 수 있다.                                                                |
| #9         | 배송 조회             | 사용자가 주문을 완료하면 이후 사용자는 피자 준비 및 배달 상황을 조회할 수 있다.                                          |
| #10        | 서비스 종료           | 사용자가 원하는 작업을 완료한 후 서비스를 종료할 수 있다.                                                                |
| ...        | ...                   | ...                                                                                                                      |

<div class="note">
  <p><strong>Note!</strong></p>
  <p>이렇게 작성된 세부 목표들은 <a href="#MakeUseCaseScenarioScript">사용 시나리오 스크립트를 작성</a>하거나 <a href="#DefineInteractionModel">interaction 모델</a>을 정의하는 기반 정보가 됩니다. 또한, <a href="/DevConsole/Guides/Deploy_Custom_Extension.md#InputDeploymentInfo">extension을 배포</a>할 때 이 정보를 등록해야 하며, 이를 기준으로 custom extension이 제대로 동작하는지 <a href="/DevConsole/Guides/Deploy_Custom_Extension.md#RequestExtensionSubmission">심사</a>를 받게 됩니다.</p>
</div>

## 사용 시나리오 스크립트 작성 {#MakeUseCaseScenarioScript}

사용 시나리오 스크립트는 사용자와 CLOVA 사이의 대화를 미리 예상한 것입니다. 세부 목표를 기반으로 다양한 사용 시나리오에 사용자와 CLOVA의 대화를 미리 예상해 봄으로써 서비스의 편의성, 흐름을 점검할 수 있습니다. [목표 수립](#SetGoal)에서 정한 세부 목표를 기준으로 예상되는 사용 시나리오 스크립트를 작성합니다. 이는 추후 [interaction 모델](#DefineInteractionModel)을 등록할 때 재사용될 수 있습니다.

사용 시나리오 스크립트를 작성할 때는 다음을 고려하여 작성할 것을 권장합니다.

* 문어체보다는 구어체로 작성합니다.
* Custom extension이 사용자에게 다음 동작에 대한 제안이나 서비스 사용 추천합니다.
* 반복/중복적인 표현은 지양합니다.
* 항상 의도하지 않은 사용자의 요청이나 상황이 발생할 수 있음을 염두에 둬야 합니다.

다음은 사용 시나리오를 연속되는 사용자 요청 방식과 일시적 명령 방식으로 나누어 스크립트를 작성한 예입니다.
* 연속되는 사용자 요청(multi-turn) 시나리오

| 발화 주체           | 발화 예시                                                                   | 관련 세부 목표     |
|-------------------|---------------------------------------------------------------------------|----------------|
| 사용자     | 피자봇 시작해줘.                                                                                                    | #1             |
| Extension | 안녕하세요. 피자봇입니다. 무엇을 도와드릴까요?                                                                             | #2             |
| 사용자      | 무슨 피자 있어?                                                                                                    | #3             |
| Extension | 콤비네이션 피자, 페퍼로니 피자, 슈퍼슈프림 피자가 있어요. 무엇을 주문하시겠어요?                                                   | #2, #3         |
| 사용자      | 콤비네이션 피자 주문할래.                                                                                             | #3             |
| Extension | 등록된 피자집은 XX피자와 YY피자가 있어요. 어디로 하시겠어요?                                                                  | #2, #4         |
| 사용자      | XX피자로 해줘.                                                                                                     | #4             |
| Extension  | XX피자 XX점의 콤비네이션 1 판, 콜라 1.5 리터 1 개를 AA동 111 번지로 보내드릴게요. 총 2 만 3 천 원, 배달원에게 직접 결제 가능해요. 주문하시겠어요? | #2, #6         |
| 사용자      | 다른 메뉴 알려줘.                                                                                                   | #7             |
| Extension | 슈퍼슈프림 1 판, 콜라 1.5 리터 1 개를 AA동 111 번지로 보내드릴게요. 총 2 만 6 천 5 백 원, 배달원에게 직접 결제 가능해요. 주문하시겠어요?          | #2, #7         |
| 사용자     | 그래.                                                                                                             | #5             |
| Extension | 주문이 완료되었습니다.                                                                                                | #8             |
| 사용자     | 피자봇 종료해.                                                                                                      | #10            |

* 단일 사용자 요청(single-turn) 시나리오

| 발화 주체   | 발화 예시                                              | 관련 세부 목표  |
|-----------|------------------------------------------------------|-------------|
| 사용자      | 피자봇에서 주문한 것 조회해줘.                               | #1, #9      |
| Extension | 지금 배달 중이에요. 조금만 기다려주세요.                       | #9          |

## Skill 이름 정의 {#DefineInvocationName}

새로운 custom extension을 작성할 때는 **skill 이름**과 **호출 이름**을 정의해야 합니다. **Skill 이름**은 skill 스토어를 통해 제공되는 custom extension의 이름입니다. **호출 이름**은 사용자가 custom extension을 사용하기 위해 CLOVA에 말할 때 부르는 이름입니다.

**Skill 이름**과 **호출 이름**이 반드시 같을 필요는 없습니다. 단, **Skill 이름**과 **호출 이름**이 많이 다르면 사용자에게 혼란을 줄 수 있으니 되도록이면 같거나 비슷한 이름을 사용하는 것이 좋습니다.

**Skill 이름**과 **호출 이름**은 다음 조건을 만족해야 합니다.

<table>
  <thead>
    <tr>
      <th style="width:40%">조건</th><th style="width:60%%">설명</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>단어 하나로 된 이름, 범용적인 말이 아니어야 함</td>
      <td>독자 브랜드나 서비스 이름을 제외하고 단어 하나로 된 이름은 사용할 수 없습니다. 또 "스포츠 뉴스"와 같은 범용적인 말은 허가되지 않으며 개발자/개발사 또는 서비스/브랜드의 이름을 조합할 것을 권장합니다. (예: "타로의 스포츠 뉴스")</td>
    </tr>
    <tr>
      <td>사람 이름이나 지명를 일컫는 말이 아니어야 함</td>
      <td>인명이나 지명으로만 구성된 이름은 사용할 수 없습니다. 다만, 인명이나 지명이 전체 이름의 일부만 사용된 것은 심사를 통해 허용될 수도 있습니다.
        <ul>
          <li>예: "세종대왕", "이순신", "서울시", "강남구"</li>
          <li>예외: "세종대왕의 한글 교실", "서울시 핫플레이스"</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>CLOVA의 기능에 영향을 주는 문구가 포함되지 않아야 함</td>
      <td>CLOVA 기능에 영향을 주는 문구를 포함된 호출 이름을 사용할 수 없습니다.
        <ul>
          <li>CLOVA 호출어: "클로바", "헤이 클로바", "샐리야", "제시카", "짱구야"</li>
          <li>CLOVA 기본 skill 호출: "오늘 날씨", "주요 뉴스"와 같이 CLOVA 기본 skill을 위해 이미 예약된 표현</li>
          <li><strong>호출 이름</strong>을 실행 종료하는 문구: "시작해줘", "종료해줘"</li>
          <li><strong>호출 이름</strong>과 함께 사용하는 조사: "~에게", "~에서"</li>
        </ul>
        <div class="note">
          <p><strong>Note!</strong></p>
          <p><strong>호출 이름</strong>은 함께 사용하는 조사와 잘 어울리는 이름이어야 합니다.</p>
        </div>
      </td>
    </tr>
    <tr>
      <td>다른 skill과 같거나 유사한 이름이 아니어야 함</td>
      <td>다른 skill이 이미 사용하고 있는 이름이거나 유사한 이름은 사용할 수 없습니다.</td>
    </tr>
    <tr>
      <td>오해를 사지 않는 이름이어야 함</td>
      <td>다음과 같이 오해를 살 수 있는 이름은 사용할 수 없습니다.
        <ul>
          <li>제 3 자 또는 {{ book.ServiceEnv.OrientedService }} 및 관련 회사 서비스로 오인할 수 있는 이름(예: 네이버 낚시 고수)</li>
          <li><strong>Skill 이름</strong>과 <strong>호출 이름</strong>의 의미가 오해를 살 수 있을 정도로 다른 이름(예: Skill 이름은 "고양이 울음 소리" 호출 이름은 "강아지 울음 소리")</li>
          <li>실제 제공하는 콘텐츠가 이름과 달라 오해를 살 수 있는 이름(예: 이름은 "고양이 울음 소리"이나 강아지 울음 소리를 콘텐츠로 제공할 때)</li>
        </ul>
      </td>
    </tr>
    <tr>
      <td>이용 약관을 위반하지 않는 이름이어야 함</td>
      <td><a href="{{ book.ServiceEnv.CEKTermsOfUseURI }}" target="_blank">CLOVA Extensions Kit 이용약관</a>을 준수해야 합니다. 제 3 자의 권리 침해나 외설적인 표현을 사용한 이름은 사용할 수 없습니다.</td>
    </tr>
    <tr>
      <td>기타 유의 사항</td>
      <td>다음과 같은 기타 유의 사항이 있습니다.
        <ul>
          <li>예외로 독자 브랜드 이름과 지적 재산, 이름과 장소같은 고유 명사는 사용 가능합니다.</li>
          <li><strong>호출 이름</strong>은 되도록이면 사용자가 발음 하기 쉽고 유사한 발음이 없는 이름을 사용하도록 권장합니다.</li>
          <li><strong>Skill 이름</strong>에 사용자가 사용 방법을 알 수 있도록 <strong>호출 이름</strong>을 괄호로 기입해주면 좋습니다.</li>
        </ul>
      </td>
    </tr>
  </tbody>
</table>

<div class="note">
<p><strong>Note!</strong></p>
<p>Skill 이름에 대한 규칙은 언제든지 변경될 수 있으며, 이미 허가된 이름이 정책에 따라 사용 불가 판정을 받을 수도 있습니다. 이점 미리 양해 부탁드립니다. 이에 대한 판단이 어렵다면 <a href="/DevConsole/Guides/Deploy_Custom_Extension.md#RequestExtensionSubmission">심사 시</a>에 의견을 입력해주십시오.</p>
</div>

## Interaction 모델 정의 {#DefineInteractionModel}

Interaction 모델이란, CLOVA가 사용자의 발화를 어떻게 인식하게 할 것인지 정의한 것으로 custom extension에 필요한 interaction 모델을 등록할 수 있습니다. 등록된 interaction 모델은 CLOVA의 [자연어 이해(NLU)](https://en.wikipedia.org/wiki/Natural-language_understanding) 시 이용되며, CLOVA는 이 interaction 모델에 의해 처리된 사용자의 요청을 정형화된 포맷(JSON)으로 바꾸어 custom extension에 전달합니다. 예를 들어, custom extension이 피자 배달 서비스를 제공한다고 가정할 때 "페퍼로니 피자 2 판 주문해줘"와 같은 발화가 사용자로부터 입력될 수 있습니다. CLOVA는 interaction 모델을 이용하여 아래와 같이 사용자 의도를 분석하고 custom extension이 처리할 수 있는 포맷(JSON)으로 데이터를 변경합니다.

![Extension_Design-Interaction_Model_Analysis_Diagram](/Design/Assets/Images/Extension_Design-Interaction_Model_Analysis_Diagram.png)

Custom extension에 필요한 interaction 모델은 CLOVA developer console에서 정의할 수 있습니다. 그 전에 우선 interaction 모델을 이해하고 설계하는 과정이 필요합니다. 이런 과정 없이 무작정 CLOVA developer console에서 interaction 모델을 정의하게 되면 작업 효율이 떨어지거나 사용자 요청이 의도된 대로 인식되지 않을 수 있습니다. 사용자의 실제 의도를 잘 파악하는 interaction 모델을 만들려면 interaction 모델을 만들기 전에 다음과 같은 내용을 이해하고 interaction 모델 설계에 반영해야 합니다.

* [Intent](#Intent)
* [Slot](#Slot)
* [발화 예시](#UtteranceExample)

### Intent {#Intent}

Intent는 custom extension이 처리할 사용자의 요청을 구별한 범주이며 주로 사용자 발화문에 사용된 **동사**형 요소에 의해 Intent가 구분됩니다. Intent는 다시 custom intent와 built-in intent로 나뉩니다.

* [Built-in intent](#BuiltinIntent)
* [Custom intent](#CustomIntent)

#### Built-in intent {#BuiltinIntent}

Built-in intent는 CLOVA 플랫폼이 일부 공통적인 사용자 요청 범주를 정하고 이를 공유하여 사용하기 위해 선언한 것입니다. 일반적으로 빈번히 발생할 수 있는 intent로 다음과 같은 built-in intent를 미리 정의해 두고 있습니다.

| Built-in intent 이름              | 의도                    | 대응하는 사용자 발화 예시                      |
|-----------------------------------|-------------------------|------------------------------------------------|
| `Clova.CancelIntent`              | 실행 취소 요청          | "취소", "취소해줘"                             |
| `Clova.GuideIntent`               | 도움말 요청             | "너 뭐 할 줄 알아?", "사용법 알려줘."          |
| `Clova.NextIntent`                | 다음 콘텐츠 요청        | "다음", "다음곡 들려줘"                        |
| `Clova.NoIntent`                  | 부정 응답(아니오, No)   | "아니", "아니요", "싫어"                       |
| `Clova.PauseIntent`               | 재생 일시 정지 요청     | "잠깐 멈춰줘", "멈춰줘"                        |
| `Clova.PreviousIntent`            | 이전 콘텐츠 요청        | "이전", "이전 곡 들려줘"                       |
| `Clova.RequestAlternativesIntent` | 새로운 콘텐츠 재생 요청 | "다른 거 틀어줘", "다른 거 들려줘"             |
| `Clova.ResumeIntent`              | 재생 재개 요청          | "다시 재생해줘", "다시 들려줘"                 |
| `Clova.StopIntent`                | 재생 중지 요청          | "중지 해줘"                                    |
| `Clova.YesIntent`                 | 긍정 응답(예, Yes)      | "응", "그래", "알겠어", "알겠습니다", "오케이" |

#### Custom intent {#CustomIntent}

Custom intent는 built-in intent와 달리 제공하려는 서비스에 특화된 사용자 요청 범주를 정의한 것입니다. Custom intent는 다음과 같은 것을 정의한 명세입니다.
* 서비스에 어떤 범주의 사용자 요청이 있는지?
* 각 사용자 요청 범주에는 어떤 정보([Slot](#Slot))가 필요한지?
* 각 사용자 요청 범주에는 어떤 다양한 [발화 예시](#UtteranceExample)가 있는지?

피자 배달 서비스를 계속 예로 들어 설명하면, 해당 서비스는 다음과 같은 요청 범주가 있을 수 있습니다.

* 메뉴 조회 요청
* 주문 요청
* 배달 조회 요청

이를 토대로 피자 배달 서비스(extension)의 interaction 모델을 정의한다는 것은 메뉴 조회 intent, 주문 intent, 배달 조회 intent와 같은 intent 목록을 선언하고 각 intent에서 어떤 정보(slot)를 취할지 어떤 발화 예시가 있는지 열거하는 것이라고 보면 됩니다. 따라서, **interaction 모델을 정의할 때 가장 먼저 해야 할 일은 custom extension이 어떤 범주의 요청을 처리해줄 것인지 정의하고 열거하는 것**입니다. 이는 custom extension을 개발할 때 비즈니스 로직, 즉 프로그램의 분기를 나누는 기준이 되기도 합니다.

![Extension_Design-Design_Interaction_Model](/Design/Assets/Images/Extension_Design-Design_Interaction_Model.png)

**사용자 요청의 범주를 나눴다면 각 범주에 이름을 정의해야 합니다.** 이는 곧 intent의 이름이 됩니다. 피자 배달 서비스의 "주문 intent"와 같은 것은 추상적인 개념과 같은 것이고 이를 custom extension이 알 수 있는 구체적인 이름 즉 식별될 수 있는 문자열로 선언해야 합니다. 예를 들면, "주문 intent"는 "OrderPizza"와 같은 이름으로 선언할 수 있습니다.

이제 "OrderPizza" intent가 사용자의 발화로부터 **어떤 정보([Slot](#Slot))를 취해야 하는지 정의**해야 하며, 어떤 식의 사용자 발화를 처리할 수 있는지 **다양한 [발화 예시](#UtteranceExample)를 열거**해야 합니다.

### Slot {#Slot}

Slot은 사용자의 발화로부터 획득하는 정보이며, 사용자 발화문에 사용된 **명사**형 요소가 slot이 될 수 있습니다. [custom intent](#Intent)를 정의할 때 해당 intent가 필요한 slot이 무엇인지 정의해야 합니다. 소프트웨어 개발에 비유해 설명하자면 intent는 특정 범주의 사용자 요청을 처리하는 함수 또는 핸들러이고 slot은 이 함수나 핸들러에 필요한 파라미터가 됩니다. 위에서 언급했던 "페퍼로니 피자 2 판 주문해줘"라는 사용자 발화를 보면 "OrderPizza" intent를 처리하려면 "페퍼로니 피자"와 같은 피자 종류에 대한 정보와 "2 판"과 같은 수량 정보가 필요하다는 것을 알 수 있습니다. Intent를 정의할 때 어떤 정보(slot)가 필요한지 미리 파악해둬야 합니다.

Slot을 선언할 때 slot이 어떤 유형의 정보인지 구분해야 하며 이를 slot 타입이라고 합니다. slot 타입은 built-in slot 타입과 custom slot 타입으로 나뉩니다.

* [Built-in slot 타입](#BuiltinSlotType)
* [Custom slot 타입](#CustomSlotType)

#### Built-in slot 타입 {#BuiltinSlotType}

Built-in slot 타입은 CLOVA에서 미리 정의해둔 정보 유형으로서 모든 서비스(extension)에서 범용적으로 사용될 수 있는 정보 표현을 정의한 것입니다. Built-in slot 타입은 주로 시간, 장소, 숫자와 같은 정보를 인식해야 할 때 사용됩니다. 위 발화를 예로 들면 "2 판"에 해당하는 정보를 인식하기 위해 built-in slot 타입을 사용할 수 있습니다. CLOVA는 다음과 같은 built-in slot 타입을 제공하고 있습니다.

| Built-in slot 타입 이름 | 설명                                            |
| ----------------------|------------------------------------------------|
| `CLOVA.DATETIME`      | 날짜 및 시간 표현에 해당하는 정보입니다. (예: "10 분 30 초", "오전 9 시", "1 시간 전", "12 시", "정오", "2017 년 8 월 4 일", "저번 달 마지막 날") |
| `CLOVA.DURATION`      | 기간 표현에 해당하는 정보입니다. (예: "하루", "밤새", "한 달", "다음 주", "주말") |
| `CLOVA.NUMBER`        | 숫자 표현에 해당하는 정보입니다. 수량 명사를 포함합니다. (예: "한번", "7 명", "하나", "30 살", "8정도", "16 칸") |
| `CLOVA.RELATIVETIME`  | 상대적인 시간 표현에 해당하는 정보입니다. (예: "앞으로", "이따가", "잠시 후", "방금", "아까") |
| `CLOVA.UNIT`          | 단위 표현에 해당하는 정보입니다. (예: "113 평", "100 메가", "25 마일") |
| `CLOVA.ORDER`        | 순서 표현에 해당하는 정보입니다. (예: "넥스트", "앞", "이전", "마지막", "다음", "이번", "지난", "마지막") |
| `CLOVA.KO_ADDRESS_[행정 구역 단위]` | 국내의 행정 구역 단위에 따라 불리는 지명 표현을 의미하는 정보입니다. CLOVA가 제공하는 행정 구역 단위는 CLOVA developer console을 통해서 확인하면 됩니다. |
| `CLOVA.WORLD_COUNTRY` | 세계의 국가명 표현에 해당하는 정보입니다. (예: "가나", "일본", "대한민국", "프랑스") |
| `CLOVA.WORLD_CITY`   | 세계의 도시명 표현에 해당하는 정보입니다. (예: "뉴욕", "파리", "런던") |
| `CLOVA.CURRENCY`      | 화폐 표현에 해당하는 정보입니다. (예: "위안", "엔", "달러", "러시아 돈", "영국 통화") |
| `CLOVA.OFFICIALDATE ` | 공휴일 및 국경일, 기념일 표현에 해당하는 정보입니다. (예: "입춘", "신정", "석가탄신일", "광복절") |

#### Custom slot 타입 {#CustomSlotType}

Custom slot 타입은 제공하는 서비스(extension)에 특화된 정보 유형을 정의한 것으로 custom slot 타입을 만들 때 주로 고유 명사 또는 명사를 지정합니다. 위 발화를 예를 들면 "OrderPizza" intent는 피자의 종류에 해당하는 정보(slot)를 사용자 발화에서 파악해야 하며 피자 종류를 나타내는 표현은 피자와 관련된 서비스에서만 사용될 가능성이 큽니다. 따라서 "PIZZA_TYPE"과 같은 custom slot 타입을 정의하고 "PIZZA_TYPE"에는 피자 배달 서비스에서 주문 가능한 "페퍼로니 피자", "콤비네이션 피자", "치즈 피자"와 같은 항목들이 표현될 수 있음을 선언할 수 있습니다.

다만, 이런 항목들은 문장에서 같은 의미를 지니지만 비슷하거나 다양하게 표현될 수 있습니다. "바베큐 피자"는 "BBQ 피자"와 같은 동의어를 가질 수 있으며, "쉬림프 골드 크러스트 피자"와 같이 이름이 길면 "쉬림프 골크 피자"처럼 사용자들이 흔히 짧게 부르는 표현이 존재할 수 있습니다. 따라서 custom slot 타입을 정의할 때 개념적으로 구분된 항목을 선언해야 할 뿐만 아니라 각 항목의 대표어와 동의어/유의어를 정의해야 합니다. 이는 사용자 발화를 인식하는 과정에서 다양하게 표현된 동의어/유의어를 대표어로 전환해주며, custom extension이 intent를 처리할 때 같은 개념에 해당하는 정보를 일관된 값으로 받을 수 있도록 해줍니다.

위와 같이 slot 타입을 정의하고 나면 각 intent에서 사용할 slot의 이름을 정의하고 해당 slot이 어떤 slot 타입을 가지는지 선언해야 합니다. 예를 들면, "OrderPizza" intent는 피자 종류 정보를 위해 "pizzaType", 피자 수량 정보를 위해 "pizzaAmount"라는 slot을 선언하고 각 slot에 미리 정의해둔 "PIZZA_TYPE" custom slot 타입과 이미 제공되고 있는 `CLOVA.NUMBER` built-in slot 타입을 지정할 수 있습니다.

### 발화 예시 {#UtteranceExample}

Intent를 정의할 때 다양한 사용자 발화 예시를 열거할 수 있습니다. 사용자는 같은 의도를 지닌 말을 말투나 상황에 따라 다양하게 표현합니다. 발화 예시는 비슷한 의도를 지닌 다양한 사용자의 표현을 CLOVA가 인식하는데 필요한 기반 데이터가 되며 위에서 언급한 slot이 사용자 발화 중 어느 위치에 있는지 파악할 때 사용됩니다. 발화 예시를 잘 입력하면 사용자 의도를 잘 인식하는 interaction 모델을 만들 수 있습니다. 발화 예시를 작성할 때 되도록이면 다음 권고 사항을 따릅니다.

* 같은 의도를 지녔지만 다른 방식으로 표현이 되는 발화 예시를 많이 입력해야 합니다.
* 패턴이 서로 겹치지 않게 표현에 다양한 변형을 주어 발화 예시를 작성합니다.
* 발화 예시 작성 개수는 다음 기준을 따릅니다.
  * Intent에 사용된 slot이 built-in slot 타입이거나 사람이 전부 인지할 수 있는 양의 사전 크기를 가진 custom slot 타입이면 해당 slot이 들어가는 발화 문장을 최소 30 개 이상 작성해야 합니다.
  * Intent에 사용된 slot이 아티스트 이름, 곡 제목, 영화 제목, 업체 이름과 같이 사전의 크기가 매우 큰 slot 타입이면 해당 slot이 들어가는 발화 문장을 최소 100 개 이상은 작성해야 합니다.
  * 간단한 형태의 표현을 가지는 Intent이면 10 개 내외의 발화 예시만 등록해도 됩니다.
* 위 기준으로 발화 예시를 입력한 후 새로운 표현이 생기거나 인식이 잘 안 되는 표현을 발견할 때마다 발화 예시를 추가하합니다.
* Slot 타입의 사전(dictionary)에 등록된 값 중에 slot인지 아닌지 판단하기 모호한 값이 있다면 해당 값을 발화 예시로 사용하여 slot임을 명시하는 것이 좋습니다. 다만, slot 타입에 모호한 값이 들어가도록 정의하지 않는 것을 더 권장합니다.

발화 예시를 많이 입력하되 패턴이 서로 겹치지 않게 표현에 다양한 변형을 주어야 한다는 의미는 다음 그림을 참조하면 이해하기 쉽습니다.

![Extension_Design-Diagram_for_Utterance_Example](/Design/Assets/Images/Extension_Design-Diagram_for_Utterance_Example.png)

예를 들어, 피자 배달 서비스의 주문과 관련된 intent(OrderPizza)에 다음과 같은 발화 예시를 작성했다고 가정합니다.

```
페퍼로니 피자 1 판 시켜줘.
페퍼로니 피자 1 판 주문해줘.
페퍼로니 피자 1 판 보내줘.
페퍼로니 피자 1 판 부탁해.
```

위 발화 예시로 CLOVA가 학습을 하게되면 `"페퍼로니"`나 `"1 판"`이라는 값이 사용자 발화에 포함되면 해당 발화가 `OrderPizza` intent로 인식할 가능성이 매우 높아집니다. 예를 들면, "페퍼로니 피자 1 판 얼마야?"와 같이 메뉴 조회를 예상한 발화가 피자를 주문을 요청한 발화로 처리되기 쉽습니다.

이를 방지하기 위해 다음과 같은 형태로 발화 예시를 작성할 것을 권장합니다.

```
페퍼로니 피자 2 판 시켜줘.
BBQ 피자 하나만 배달시켜줄래?
콤비네이션 세 개 보내주면 좋겠어.
쉬림프 골크 피자 빨리 부탁해, 배고파.
```

발화를 명사(피자 종류), 명사(수량), 동사(의도)와 같은 패턴으로 구성했으며, 일상적으로 사용하는 조사, 어미, 부사, 감탄사와 같은 품사도 포함되어 있습니다. 발화 패턴이 더 없다면 이제 패턴을 재사용하고 slot의 값을 바꿔가면서 발화 예시를 권장 기준만큼 추가하면 됩니다. 다음 사항을 따르면서 발화 예시를 추가해야 합니다.
* 발화 예시에 사용된 slot의 값에 변화를 주면서 문장을 추가합니다.
* 조사, 어미, 부사, 감탄사와 같은 품사 사용에 변화를 주면서 문장을 추가합니다.
* **특정 값의 조합이 자주 사용되지 않도록 유의하는 것이 좋습니다.** 예를 들면, "페퍼로니 피자 2 개 시켜줘"와 "페퍼로니 피자를 1 판만 시켜주세요."는 어미/조사와 수량 값에 변화를 줬지만 `"페퍼로니"`와 `"시켜주다"`라는 값 조합이 중복된 예입니다.

```
바베큐 5 개만 얼른 시켜.
페퍼로니 1 판 먹을래.
야채 피자 부탁해.
맛있는 치즈 피자 넷 주문해주라.
```

"OrderPizza" intent에 관련된 발화를 텍스트로 열거한 후 각 slot에 해당하는 영역을 다음과 같이 표시하게 됩니다.

{% raw %}

```
<pizzaType>페퍼로니 피자</pizzaType> <pizzaAmount>2 판</pizzaAmount> 시켜줘.
<pizzaType>BBQ 피자</pizzaType> <pizzaAmount>하나</pizzaAmount>만 배달시켜줄래?
<pizzaType>콤비네이션</pizzaType> <pizzaAmount>세 개</pizzaAmount> 보내주면 좋겠어.
<pizzaType>쉬림프 골크 피자</pizzaType> 빨리 부탁해, 배고파.
<pizzaType>바베큐</pizzaType> <pizzaAmount>5 개</pizzaAmount>만 얼른 시켜.
<pizzaType>페퍼로니</pizzaType> <pizzaAmount>1 판</pizzaAmount> 먹을래.
<pizzaType>야채 피자</pizzaType> 부탁해.
맛있는 <pizzaType>치즈 피자</pizzaType> <pizzaAmount>넷</pizzaAmount> 주문해주라.
...
```
{% endraw %}

<div class="note">
  <p><strong>Note!</strong></p>
  <p>추후 <a href="/DevConsole/Guides/Test_Custom_Extension.md#TestInteractionModel">interaction 모델 테스트</a>나 실제 사용자 로그를 통해 완성도를 높여 나갈 수 있습니다. Interaction 모델을 테스트할 때는 발화 예시를 작성한 사람이 아닌 다른 사람이 테스트해보는 것이 좋습니다. 이 방법은 새로운 표현 패턴을 찾는데 도움이 됩니다.</p>
</div>


[CLOVA developer console](/DevConsole/ClovaDevConsole_Overview.md)을 이용하여 위에서 정의한 [interaction 모델을 등록](/DevConsole/Guides/Register_Interaction_Model.md)하게 되면 [등록한 custom extension](/DevConsole/Guides/Register_Custom_Extension.md)이  다음과 같은 JSON 메시지를 수신하게 됩니다.

{% raw %}

```json
// Custom intent: 페퍼로니 피자 2 판 주문해줘.
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b"
      }
    }
  },
  "request": {
    "type": "IntentRequest",
    "intent": {
      "name": "OrderPizza",
      "slots": {
        "pizzaAmount": {
          "name": "pizzaAmount",
          "value": "2"
        },
        "pizzaType": {
          "name": "pizzaType",
          "value": "페퍼로니"
        }
      }
    }
  }
}

// Built-in intent: 취소해줘
{
  "version": "0.1.0",
  "session": {
    "new": false,
    "sessionAttributes": {},
    "sessionId": "a29cfead-c5ba-474d-8745-6c1a6625f0c5",
    "user": {
      "userId": "V0qe",
      "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
    }
  },
  "context": {
    "System": {
      "application": {
        "applicationId": "com.example.extension.pizzabot"
      },
      "user": {
        "userId": "V0qe",
        "accessToken": "XHapQasdfsdfFsdfasdflQQ7"
      },
      "device": {
        "deviceId": "096e6b27-1717-33e9-b0a7-510a48658a9b"
      }
    }
  },
  "request": {
    "type": "IntentRequest",
    "intent": {
      "name": "Clova.CancelIntent",
      "slots": {}
    }
  }
}
```

{% endraw %}

## 응답 유형 결정 {#DecideSoundOutputType}

Custom extension은 사용자의 요청을 처리한 후 그 결과를 CLOVA를 통해 사용자에게 전달해야 합니다. CLOVA는 기본적으로 사용자와 대화할 때 소리를 이용하며, 요청을 받을 때 뿐만 아니라 사용자에게 응답할 때도 소리를 이용합니다. CLOVA는 소리를 이용한 응답 유형으로 다음과 같은 유형을 제공합니다. Custom extension은 사용자의 사용 시나리오에 따라 그에 맞는 유형으로 응답을 제공해야 합니다.

* [음성 출력 유형](#OutputSpeech)
* [오디오 콘텐츠 재생 유형](#AudioPlayer)

### 음성 출력 유형 {#OutputSpeech}

문자로 표현된 정보를 음성 합성 기술을 이용해 가공된 목소리로 음성(TTS)을 출력하는 유형입니다. 주로 사용자의 질문이나 요청에 대답하는 용도로 많이 사용됩니다. 응답은 1 개 이상의 음성 출력(TTS)으로 구성될 수 있으며, 짧은 효과음(.mp3)도 함께 제공할 수 있습니다.

음성 출력 유형으로 응답을 작성할 때 다음 규칙을 지켜야 합니다.
* 응답 하나 당 약 500 자 또는 90 초 이하가 되도록 만들 것을 권장합니다. 응답이 길면 사용자가 이해하기 어려울 수 있습니다.
* 효과음은 비교적 짧은 길이를 가진 오디오 콘텐츠를 사용합니다.
* 효과음은 반드시 응답의 맨 처음에 한 번만 나오도록 구성해야 합니다.
  * 올바른 예: 효과음(.mp3) > 음성 출력(TTS) > 음성 출력(TTS) > ...
  * 잘못된 예 1: 음성 출력(TTS) > 효과음(.mp3) > 음성 출력(TTS) > ...
  * 잘못된 예 2: 효과음(.mp3) > 음성 출력(TTS) > 효과음(.mp3) > 음성 출력(TTS) > ...
* 하나의 응답을 10 개 이하의 음성 출력으로 구성할 것을 권장합니다.

다음은 음성 출력 유형에 해당하는 예입니다.
```
// 예제 1: 짧은 안내 문장
"수도 이름 맞추기 퀴즈입니다."

// 예제 2: 자세한 설명과 문제로 구성된 응답
1 번 TTS: "나라 수도이름 맞추기를 중간에 그만두시려면 '그만'이라고 이야기하고, 문제를 다시 듣고 싶으면 '다시', 다른 문제를 푸실려면 '다른 문제'라고 말씀하세요."
2 번 TTS: "미국의 수도는 어디인가요?"

// 예제 3: 효과음이 포함된 응답
1 번 효과음(.mp3): 정답 효과음 재생
2 번 TTS: "정답입니다."
```

<div class="note">
  <p><strong>Note!</strong></p>
  <p>음성 출력 유형의 응답에 대한 구현 설명은 <a href="/Develop/Guides/Build_Custom_Extension.md#ReturnCustomExtensionResponse">Custom extension 응답 반환하기</a>를 참조합니다.</p>
</div>


### 오디오 콘텐츠 재생 유형 {#AudioPlayer}

음악과 같이 긴 시간동안 오디오 콘텐츠를 재생하는 유형이며, 주로 음악을 제공하는 skill에서 많이 사용하는 유형입니다. 이 유형은 긴 시간동안 오디오 콘텐츠를 재생해야 할 뿐만 아니라 일시 정지, 재개, 중지를 해야할 때 사용됩니다. 따라서 오디오 콘텐츠 재생 유형으로 응답하려면 custom extension이 다음과 같이 오디오를 재생할 수 있어야 합니다.

* Custom extension은 사용자가 요청하면 클라이언트가 오디오 콘텐츠를 재생할 수 있도록 응답 메시지(`AudioPlayer.Play`)를 반환해야 합니다.
* Custom extension은 사용자가 원하면 언제든지 오디오 콘텐츠를 일시 정지 또는 중지할 수 있어야 합니다.
* Custom extension은 일시 정지 또는 중지된 콘텐츠를 다시 재개 또는 재생할 수 있어야 합니다.
* Custom extension은 이전 곡이나 다음 곡으로 재생을 넘길 수 있어야 합니다.

다음은 오디오 콘텐츠 재생 유형의 간단한 사용 시나리오입니다.

> <p class="ldiag">"클래식 박스 시작해줘"</p>
> <p class="rdiag">"어떤 클래식 음악 틀어드릴까요?"(TTS)</p>
> <p class="ldiag">"비발디의 사계 틀어줘"</p>
> <p class="rdiag">"네, 비발디의 사계 1 악장을 들려드릴게요."(TTS)</p>
> <p class="rdiag">비발디 사계 1 악장 재생 지시(AudioPlayer.Play)</p>
> <p class="ldiag">"클로바, 잠깐 멈춰줘."</p>
> <p class="rdiag">재생 중지 지시(PlaybackController.Pause)</p>
> <p class="ldiag">"클로바, 다시 재생해줘."</p>
> <p class="rdiag">재생 재개 지시(PlaybackController.Resume)</p>
> <p class="ldiag">"다음"</p>
> <p class="rdiag">비발디 사계 2 악장 재생 지시(AudioPlayer.Play)</p>

<div class="note">
  <p><strong>Note!</strong></p>
  <p>오디오 콘텐츠 재생 유형으로 응답하는 방법은 <a href="/Develop/Guides/Provide_Audio_Content.md">오디오 콘텐츠 제공하기</a>를 참조합니다.</p>
</div>

## 지속적인 업데이트 {#ContinuousUpdate}

Custom extension을 개발할 때 사용자가 어떤 발화를 할지 예측하여 시나리오를 만들고 이를 custom extension에 적용합니다. 이런 활동은 custom extension을 개발할 때 도움이 되지만 사용자들이 실제 이용하는 방식과 차이가 있을 수 있고 사용자의 모든 사용 패턴을 대변했다고 할 수 없습니다. 즉, 사용자는 예상과 다르게 custom extension을 사용할 수 있습니다. 따라서, custom extension을 배포한 이후에도 custom extension의 기능이나 대화 흐름을 지속적으로 개선하는 활동을 해야 사용자의 만족도를 향상시킬 수 있습니다.

Custom extension 등록한 후 CLOVA 플랫폼이 제공하는 통계 데이터나 유입된 사용자 발화 기록(추후 제공 예정) 분석하여 꾸준히 custom extension을 업데이트해야 합니다.
