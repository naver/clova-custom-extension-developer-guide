<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

# Custom extension 테스트하기
등록한 custom extension이나 interaction 모델은 배포하기 전에 테스트해볼 수 있습니다. 다음을 항목을 수행하여 custom extension과 interaction 모델을 테스트합니다.

* (Custom extension 전용) [Interaction 모델 빌드하기](#BuildInteractionModel)
* (Custom extension 전용) [Interaction 모델 테스트하기](#TestInteractionModel)
* [CLOVA 앱으로 custom extension 테스트하기](#TestOnCLOVAApp)

## Interaction 모델 빌드하기 {#BuildInteractionModel}

Custom extension을 배포하려면 [interaction 모델이 등록](/DevConsole/Guides/Register_Interaction_Model.md)되어 있어야 합니다. 정의된 interaction 모델은 빌드 과정을 거쳐야 새로 작성했거나 또는 업데이트한 내용을 [테스트](#TestInteractionModel)하거나 사용할 수 있습니다. 다음과 같이 정의된 interaction 모델을 빌드할 수 있습니다.

1. 등록한 custom extension 목록에서 interaction 모델을 빌드하려는 custom extension 항목의 **{{ book.DevConsole.cek_edit }}** 메뉴를 누르십시오.<br />
  ![DevConsole-Interaction_Model_Menu](/DevConsole/Assets/Images/DevConsole-Interaction_Model_Menu.png)
2. **{{ book.DevConsole.cek_interaction_model }} : {{ book.DevConsole.cek_builder_header_title_dashboard }}** 화면에서 왼쪽 상단에 있는 **{{ book.DevConsole.cek_builder_menu_build }}** 버튼을 누르십시오. 그러면 interaction 모델 빌드가 시작됩니다.<br />
  Interaction 모델의 크기에 따라 3~5 분 정도 소요될 수 있습니다.<br />
  ![DevConsole-Build_Interaction_Model](/DevConsole/Assets/Images/DevConsole-Build_Interaction_Model.png)

<div class="tip">
  <p><strong>Tip!</strong></p>
  <p>빌드 중에 <strong>{{ book.DevConsole.cek_interaction_model }} : {{ book.DevConsole.cek_builder_header_title_dashboard }}</strong> 내에서 다른 메뉴로 이동하더라도 빌드가 취소되지 않습니다. 빌드를 시작한 이후에 얼마든지 메뉴 이동 및 내용 편집이 가능합니다.</p>
</div>

## Interaction 모델 테스트하기 {#TestInteractionModel}

[Interaction 모델 빌드](#BuildInteractionModel)가 완료되면, interaction 모델을 테스트할 수 있습니다. 다음과 같이 발화문을 테스트해볼 수 있습니다.

1. 왼쪽 사이드 메뉴 아래 **{{ book.DevConsole.cek_test }}** 메뉴를 누르십시오.<br />
  메뉴를 누르면 **{{ book.DevConsole.cek_interaction_model }}: {{ book.DevConsole.cek_test }}** 화면이 표시됩니다.<br />
  ![DevConsole-Test_Menu](/DevConsole/Assets/Images/DevConsole-Test_Menu.png)
2. **{{ book.DevConsole.cek_builder_test_expression_title }}** 필드에 테스트할 발화문을 입력하고 **{{ book.DevConsole.cek_builder_test_request_test }}** 버튼을 누르십시오.</li>
  ![DevConsole-Test_Utterance_Example](/DevConsole/Assets/Images/DevConsole-Test_Utterance_Example.png)

테스트를 완료하면 다음과 같은 결과를 확인할 수 있습니다. 아래 결과를 토대로 다음과 같은 항목을 확인해야 합니다.

* **{{ book.DevConsole.cek_builder_test_service_response }}** 항목을 보고 [등록한 custom extension](/DevConsole/Guides/Register_Custom_Extension.md)이 제대로 응답하는지 확인해야 합니다.
* **{{ book.DevConsole.cek_builder_test_intent_result }}** 항목과 **{{ book.DevConsole.cek_builder_test_slot_result }}** 항목을 보고 의도한대로 intent와 slot이 인식되는지 확인해야 합니다.
* **{{ book.DevConsole.cek_builder_test_request_json }}** 항목을 보고 CEK가 custom extension으로 보내는 [요청 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtRequestMessage)에 이상이 없는지 확인해야 합니다. 뿐만 아니라 해당 JSON의 내용을 수정한 후 **{{ book.DevConsole.cek_builder_test_test_again }}** 버튼을 누르면 테스트를 다시 수행할 수 있습니다.
* **{{ book.DevConsole.cek_builder_test_response_json }}** 항목을 보고 등록한 custom extension이 의도한대로 [응답 메시지](/Develop/References/Custom_Extension_Message.md#CustomExtResponseMessage)를 보내는지 확인해야 합니다.

![DevConsole-Test_Result](/DevConsole/Assets/Images/DevConsole-Test_Result.png)

<!-- Start of the shared content: TestOnCLOVAApp -->

## CLOVA 앱으로 custom extension 테스트하기 {#TestOnCLOVAApp}

Custom extension을 실제 클라이언트인 CLOVA 앱에서 테스트해볼 수 있습니다. 이를 위해 custom extension 기본 정보를 등록하는 페이지의 **{{ book.DevConsole.cek_tester }}** 필드에 개발자 본인이나 custom extension을 테스트할 사람의 <strong>{{ book.ServiceEnv.OrientedService }} 계정</strong>을 입력해야 합니다. 계정을 추가한 후 **{{ book.DevConsole.cek_save }}** 버튼을 누르면 입력한 계정이 인증된 CLOVA 앱에서 개발 중인 custom extension을 테스트할 수 있습니다. CLOVA 앱에서 테스트를 중지하려면 입력한 계정 정보를 삭제하면 됩니다.

![DevConsole-Add_Tester_ID_For_Custom_Extension](/DevConsole/Assets/Images/DevConsole-Add_Tester_ID_For_Custom_Extension.png)

<div class="note">
  <p><strong>Note!</strong></p>
  <p>테스터 ID를 등록한 후 조금 기다리면 custom extension을 테스트해 볼 수 있습니다. 만약, 1 시간 정도가 지나도 custom extension을 테스트할 수 없으면 포럼이나 제휴 담당자를 통해 문의하시기 바랍니다.</p>
</div>

<!-- End of the shared content -->
