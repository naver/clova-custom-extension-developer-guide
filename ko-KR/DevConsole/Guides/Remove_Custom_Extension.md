<!-- Note! This content includes shared parts. Therefore, when you update this, you should beware of synchronization. -->

<!-- Start of the shared content: RemovingExtension -->

# Custom extension 중지 및 삭제하기

심사 요청하기 이전 단계의 extension이라면 [기본 정보를 입력하는 메뉴](/DevConsole/Guides/Register_Custom_Extension.md#InputExtensionInfo)에서 해당 extension을 삭제할 수 있습니다.

![DevConsole-Remove_Extension](/DevConsole/Assets/Images/DevConsole-Remove_Extension.png)

다만, 다음과 같은 상태의 extension은 삭제할 수 없습니다.

* 심사 중인 extension
* 서비스 중인 extension

심사 중인 extension은 언제든지 심사를 취소하고 삭제할 수 있습니다.

![DevConsole-Cancel_Submission](/DevConsole/Assets/Images/DevConsole-Cancel_Submission.png)

만약, extension이 심사를 통과하여 서비스 중인 상태라면 서비스를 중지한 후에 extension을 삭제할 수 있습니다. 서비스를 중지하면 extension의 상태가 **{{ book.DevConsole.cek_status_dev }}**인 상태로 변경됩니다.

<div class="note">
  <p><strong>Note!</strong></p>
  <p>서비스를 중지할 때 CLOVA 운영팀의 확인이 필요합니다. 따라서, extension을 중지하려면 <a href="mailto:{{ book.ServiceEnv.ExtensionAdminEmail }}">{{ book.ServiceEnv.ExtensionAdminEmail }}</a>로 연락합니다.</p>
</div>

<!-- End of the shared content -->
