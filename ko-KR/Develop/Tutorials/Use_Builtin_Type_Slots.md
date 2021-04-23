# 사용자가 입력한 정보 활용하기
이 튜토리얼에서는 [기초적인 extension 만들기](/Develop/Tutorials/Build_Simple_Extension.md)에서 만든 샘플 주사위 extension이 사용자의 요청에 따라 주사위를 1 개 이상 던지도록 하는 법을 알아봅니다.

사용자의 음성 명령에는 extension이 수행할 동작 외에 그 동작에 필요한 추가적인 정보가 들어있을 수 있습니다. [튜토리얼 개요](/Develop/Tutorials/Introduction.md)에서 기술한 샘플 주사위 extension을 사용법을 다시 봅시다.

{% include "/Develop/Tutorials/BasicInformation/DICE_Sample_Dialog.md" %}

두 번째 대화에서 사용자는 "주사위 **2 개** 던져줘"라고 요청했고, 여기서 "2 개"가 바로 "주사위 던지기"라는 동작에 필요한 추가적인 정보입니다.

Interaction 모델에서는 이런 추가 정보를 [slot](/Design/Design_Custom_Extension.md#Slot)이라고 부릅니다. Extension에서 추가 정보를 사용하려면, interaction 모델을 정의할 때 어떤 추가 정보가 들어올지 미리 파악한 뒤 알맞은 slot을 등록해야 합니다. CLOVA는 이렇게 등록된 slot을 기반으로 사용자 요청에 포함된 추가 정보를 알아낼 수 있습니다.

추가 정보를 처리하는 방법은 다음과 같습니다.
* 1 단계. Interaction 모델에 slot 등록(CLOVA developer console에서 작업)
* 2 단계. Slot 처리 구현(Extension 서버에서 작업)
* 3 단계. Slot 동작 테스트(CLOVA developer console에서 작업)

## 1 단계. Interaction 모델에 slot 등록 {#Step1}

사용자가 던질 주사위의 개수를 지정할 수 있도록 interaction 모델을 수정해야 합니다.

이를 위해 우선 slot에 담을 정보 유형을 결정하여 interaction 모델에 slot 타입을 선언하고, 이 타입을 사용할 slot을 intent에 등록한 뒤, 추가 정보가 포함된 사용자 발화 예시를 입력하여 CLOVA가 slot을 인식할 수 있도록 해줍니다.

### 사용할 slot 타입 선언하기
Slot에 담을 추가 정보의 유형에 따라 slot의 타입을 정해야 합니다. 예를 들어, 주사위의 개수는 숫자로 나타낼 수 있습니다.

CLOVA는 모든 extension이 범용적으로 사용할 수 있도록 일반적으로 쓰이는 정보 유형을 미리 정의해두었고, 이를 [built-in slot 타입](/Design/Design_Custom_Extension.md#BuiltinSlotType)이라고 합니다. 숫자 타입은 `CLOVA.NUMBER`라는 built-in slot 타입으로 정의되어 있으므로, 주사위의 개수를 처리하기 위한 별도의 유형을 만들지 않아도 됩니다.

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>Built-in slot 타입으로 정의되지 않은 extension 고유의 정보 유형은 <a href="/Design/Design_Custom_Extension.md#CustomSlotType">custom slot 타입</a>을 정의하여 처리할 수 있습니다.</p>
</div>

<a href="{{ book.ServiceEnv.DeveloperConsoleURI }}/cek/#/list" target="_blank">CLOVA developer console</a>에 접속하여 다음과 같이 샘플 주사위 extension에서 사용할 slot 타입을 선언합니다.

1. 샘플 주사위의 **{{ book.DevConsole.cek_interaction_model }}** 항목 내 **{{ book.DevConsole.cek_edit }}** 버튼을 누르십시오.
2. **{{ book.DevConsole.cek_builder_list_title_slottype }}** 오른쪽에 있는 <img class="inlineImage" src="/Develop/Assets/Images/DevConsole_Plus_Button.png" /> 버튼을 누르십시오.
3. **{{ book.DevConsole.cek_builder_new_slottype_builtin_title }}** 아래의 테이블에서 `CLOVA.NUMBER`의 체크박스를 선택합니다.<br />
  ![CEK_Tutorial_Builtin_Type_Slots_Register_Slot_Type](/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slots_Register_Slot_Type.png)
4. **{{ book.DevConsole.cek_builder_new_slottype_builtin_title }}** 오른쪽의 **{{ book.DevConsole.cek_save }}** 버튼을 누르십시오.

### Intent에 slot 등록하기
던질 주사위의 개수는 주사위를 던지는 동작에 필요한 추가 정보입니다. 주사위를 던지는 동작은 첫 번째 튜토리얼에서 `ThrowDiceIntent`라는 intent로 등록했으므로, 이 intent에 주사위의 개수를 의미하는 slot을 등록해야 합니다.
앞서 slot 타입을 선언했던 화면에서 다음과 같이 slot을 등록합니다.

1. **{{ book.DevConsole.cek_builder_list_title_intent }}** 아래에 있는 custom intent인 `ThrowDiceIntent`를 선택하십시오.
2. **{{ book.DevConsole.cek_builder_intent_slot_title }}** 아래의 입력란에 "diceCount"라고 입력하십시오.
3. 엔터키 또는 오른쪽에 있는 <img class="inlineImage" src="/Develop/Assets/Images/DevConsole_Plus_Button.png" /> 버튼을 누르십시오.
4. 등록한 "diceCount" 오른쪽 **{{ book.DevConsole.cek_builder_utterance_select_slot }}** 콤보박스를 누르십시오.
5. 나타난 목록 중에서 앞서 등록한 **{{ book.DevConsole.cek_builder_select_slottype_builtin }}**의 `CLOVA.NUMBER`를 선택하십시오.<br />
  ![CEK_Tutorial_Builtin_Type_Slots_Add_Slot](/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slots_Add_Slot.png)
6. 화면 오른쪽 상단의 **{{ book.DevConsole.cek_save }}** 버튼을 누르십시오.

### 발화 예시 입력하기
첫 번째 튜토리얼에서는 단순히 주사위를 던져달라는 문장만 예시로 입력했으나, 이제는 slot을 이용하여 주사위 개수를 지정하는 새로운 문장을 예시로 입력해야 합니다.

앞서 slot을 등록했던 화면에서 다음과 같이 발화 예시 문장을 입력합니다.

1. **{{ book.DevConsole.cek_builder_intent_expression_title }}** 아래의 입력란에 "주사위 두 개 굴려"라고 입력하십시오.<br />
  ![CEK_Tutorial_Builtin_Type_Slots_Sample_Utterance](/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slots_Sample_Utterance.png)
2. 엔터키 또는 <img class="inlineImage" src="/Develop/Assets/Images/DevConsole_Plus_Button.png" /> 버튼을 누르십시오.
3. 등록된 문장에서 "두 개"라는 단어를 마우스로 드래그하여 선택하십시오.
4. **{{ book.DevConsole.cek_builder_slot_layer_select_slot }}** 밑에 있는 "diceCount"를 선택하십시오.<br />
  ![CEK_Tutorial_Builtin_Type_Slots_Set_Slot](/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slots_Set_Slot.png)
5. "하나 던져봐", "다섯 개의 주사위 굴려"라는 문장으로 1-4 단계를 반복하십시오.

## 2 단계. Slot 처리 구현 {#Step2}

샘플 주사위 extension이 slot을 처리할 수 있도록 코드를 변경해야 합니다.
여기서는 사전에 구현된 소스 코드를 참고하여 어떤 부분이 변경되었는지 살펴보기 위해 [첫 번째 튜토리얼](/Develop/Tutorials/Build_Simple_Extension.md)의 저장소를 재사용합니다.
다음과 같이 로컬 저장소로 이동하여 `tutorial3` 브랜치로 전환합니다.

```bash
cd /path/to/your_sample_dice_directory
git fetch
git checkout tutorial3
```

샘플 주사위 extension은 `clova/index.js` 파일의 `intentRequest()`에서 slot을 처리합니다.

```javascript
intentRequest(cekResponse) {
  const intent = this.request.intent.name
  const slots = this.request.intent.slots

  switch (intent) {
    case "ThrowDiceIntent":
      let diceCount = 1
      if (!!slots) {
        const diceCountSlot = slots.diceCount
        if (slots.length != 0 && diceCountSlot) {
          diceCount = parseInt(diceCountSlot.value)
        }

        if (isNaN(diceCount)) {
          diceCount = 1
        }
      }
      ...
  }
  ...
}
```

위 코드에서 보는 것처럼, CLOVA로부터 받은 요청 메시지에서 slot 정보를 추출(`this.request.intent.slots`)한 뒤 , 앞서 interaction 모델에 등록한 "diceCount"라는 slot(`slots.diceCount`)이 있으면 그 값을 정수 형태로 읽어옵니다. 이렇게 읽은 값이 던질 주사위의 개수이며, slot이 없거나 정수 형태의 값인 아니면 기본값인 1로 판단합니다.

변경된 코드를 extension 서버에서 실행합니다.

## 3 단계. Slot 동작 테스트 {#Step3}

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
    <img src="/Develop/Assets/Images/CEK_Tutorial_Builtin_Type_Slot_Test.png" />
    <div class="note">
      <p><strong>Note!</strong></p>
      <p>외부에서 접근할 수 있는 extension 서버 URI를 등록하지 않았다면, <strong>{{ book.DevConsole.cek_builder_test_service_response }}</strong>은 "{{ book.DevConsole.cek_builder_test_no_response }}"라고 나타납니다.</p>
    </div>
  </li>
  <li>"주사위 열 개 굴려", "네 개 주사위 던져"와 같은 문장으로 4-6 단계를 반복하십시오.</li>
</ol>

인식이 잘 되지 않으면 좀 더 다양한 발화 예시를 추가하여 인식 확률을 높일 수 있습니다.

이제 샘플 주사위 extension은 주사위를 1 개 이상 던질 수 있게 되었습니다.
같은 방법으로 주사위를 1 번 이상 던지게 하거나 숫자가 아닌 다른 값을 가진 주사위를 던지게 할 수 있습니다.
