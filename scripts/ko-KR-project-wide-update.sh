#!/bin/sh

echo "Clova -> CLOVA"
egrep -lRZ '([^/|^_|^`]|^)(Clova)([^/|^_|^\.|^"|^`|^;])' ./ko-KR | xargs -0  sed -i '' -e 's#\([^/_`]\)\(Clova\)\([^/_\."`;]\)#\1CLOVA\3#g'

egrep -lRZ '^(Clova)([^/|^_|^\.|^"|^`|^;])' ./ko-KR | xargs -0  sed -i '' -e 's#^\(Clova\)\([^/_\."`;]\)#CLOVA\2#g'

egrep -lRZ 'participant\s"Clova' ./ko-KR | xargs -0  sed -i '' -e 's#participant "Clova#participant "CLOVA#g'

egrep -lRZ '\[CLOVA\]\(\/Develop\/References\/MessageInterfaces\/Clova\.md\)' ./ko-KR | xargs -0  sed -i '' -e 's#\[CLOVA\](/Develop/References/MessageInterfaces/Clova\.md)#[Clova](/Develop/References/MessageInterfaces/Clova.md)#g'

egrep -lRZ '(CLOVA\s)(인터페이스|네임스페이스)' ./ko-KR | xargs -0  sed -i '' -e 's#CLOVA 인터페이스#Clova 인터페이스#g' -e 's#CLOVA 네임스페이스#Clova 네임스페이스#g'

egrep -lRZ 'Hi,\smy\sname\sis\sClova' ./ko-KR | xargs -0  sed -i '' -e 's#Hi, my name is Clova#Hi, my name is CLOVA#g'

egrep -lRZ '("CLOVA)(Home|Skill)(")' ./ko-KR | xargs -0  sed -i '' -e 's#"CLOVAHome"#"ClovaHome"#g' -e 's#\"CLOVASkill"#"ClovaSkill"#g'

egrep -lRZ 'X-CLOVA-Device-Tags' ./ko-KR | xargs -0  sed -i '' -e 's#X-CLOVA-Device-Tags#X-Clova-Device-Tags#g'

egrep -lRZ 'X-CLOVA-Extension-' ./ko-KR | xargs -0  sed -i '' -e 's#X-CLOVA-Extension-#X-Clova-Extension-#g'

echo "에게 -> 에"

egrep -lRZ '(Clova|CLOVA|Clova\s앱|CLOVA\s앱|클라이언트\([^)]*\)|클라이언트|CIC|CEK|[E|e]xtension|기기|대상)에게' ./ko-KR | xargs -0  sed -i '' -e 's#\Clova에게#CLOVA에#g' -e 's#CLOVA에게#CLOVA에#g' -e 's#Clova 앱에게#CLOVA 앱에#g' -e 's#CLOVA 앱에게#CLOVA 앱에#g' -e 's#클라이언트에게#클라이언트에#g' -e 's#CIC에게#CIC에#g' -e 's#CEK에게#CEK에#g' -e 's#\([Ee]xtension\)에게#\1에#g' -e 's#대상에게#대상에#g' -e 's#기기에게#기기에#g'

egrep -lRZ '(사용자|유저|개발자|담당자|운영자)(에)(\s)' ./ko-KR | xargs -0  sed -i '' -e 's#사용자에 #사용자에게 #g' -e 's#유저에 #유저에게 #g' -e 's#개발자에 #개발자에게 #g' -e 's#담당자에 #담당자에게 #g' -e 's#운영자에 #운영자에게 #g'

egrep -lRZ '에게\s의해' ./ko-KR | xargs -0  sed -i '' -e 's#에게 의해#에 의해#g'