<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

<!-- Start of the shared content: UpdatingExtension -->

# Custom extension 업데이트하기

Extension이 심사를 통과하여 extension 배포가 승인되면 extension은 **{{ book.DevConsole.cek_status_prd }}**인 상태가 됩니다. 이때, CLOVA developer console은 extension을 다음과 같이 두 가지 버전으로 만듭니다.

* **{{ book.DevConsole.cek_version_service }}** 버전: 현재 **{{ book.DevConsole.cek_status_prd }}**인 extension의 원본 정보를 가진 버전이며, extension에 대한 정보를 조회만할 수 있습니다.
* **{{ book.DevConsole.cek_version_test }}** 버전: 배포된 extension의 원본 정보를 복사하여 만든 버전이며, extension을 업데이트할 때 사용됩니다.

![DevConsole-Extension_List_After_Submission](/DevConsole/Assets/Images/DevConsole-Extension_List_After_Submission.png)

**{{ book.DevConsole.cek_version_service }}** 버전의 extension 정보는 현재 서비스 중인 내용 반영하고 있으며 더 이상 수정할 수 없습니다. 따라서 복사된 **{{ book.DevConsole.cek_version_test }}** 버전을 이용하여 extension을 업데이트해야 합니다. extension에 다음과 같은 업데이트 사항이 생기면 이를 **{{ book.DevConsole.cek_version_test }}** 버전 extension 반영한 후 심사를 다시 신청하면 됩니다.

다음과 같은 것이 업데이트될 수 있습니다.

* [기본 정보](/DevConsole/Guides/Register_Custom_Extension.md#InputExtensionInfo)
* [서버 연동 정보](/DevConsole/Guides/Register_Custom_Extension.md#SetServerConnection)
* [Interaction 모델](/DevConsole/Guides/Register_Interaction_Model.md)
* [배포 정보](/DevConsole/Guides/Deploy_Custom_Extension.md)

심사를 통과하면 **{{ book.DevConsole.cek_version_service }}** 버전에 업데이트 사항이 반영된 **{{ book.DevConsole.cek_version_test }}** 버전으로 교체됩니다. 그리고 다시 **{{ book.DevConsole.cek_version_service }}** 버전의 extension 정보를 복사하여 새로운 **{{ book.DevConsole.cek_version_test }}** 버전의 extension 정보를 생성합니다.

다음 그림은 CLOVA developer console에서 extension이 업데이트되는 구조를 보여줍니다.

![DevConsole-Branch_Chart_For_Extension_Update](/DevConsole/Assets/Images/DevConsole-Branch_Chart_For_Extension_Update.png)

<!-- End of the shared content -->
